# ==========================================================================
#
# ZoneMinder IPCAM2MP Control Protocol Module, $Date: 2009-11-25 09:20:00 +0000 (Wed, 04 Nov 2009) $, $Revision: 0001 $
# Copyright (C) 2001-2008  Philip Coombes
#
# Modified for China 2MP NetIpCam camera by Radmilo Feliox n 2015-05-05 00:03:00
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# ==========================================================================
#
# This module contains the implementation of the China 2MP NetIpCam camera
# control protocol.
#
# ==========================================================================
package ZoneMinder::Control::Jennov;

use 5.006;
use strict;
use warnings;

require ZoneMinder::Base;
require ZoneMinder::Control;

our @ISA = qw(ZoneMinder::Control);
our $VERSION = $ZoneMinder::Base::VERSION;

# ==========================================================================
#
# Jennov Control Protocol
#
# ==========================================================================
use ZoneMinder::Logger qw(:all);
use ZoneMinder::Config qw(:all);
use Time::HiRes qw( usleep );

my $loopfactor=100000;

sub new
{
    my $class = shift;
    my $id = shift;
    my $self = ZoneMinder::Control->new( $id );
    my $logindetails = "";
    bless( $self, $class );
    srand( time() );
    return $self;
}

our $AUTOLOAD;

sub AUTOLOAD
{
    my $self = shift;
    my $class = ref($self) || croak( "$self not object" );
    my $name = $AUTOLOAD;
    $name =~ s/.*://;
    if ( exists($self->{$name}) ) {
      return( $self->{$name} );
    }
    Fatal( "Can't access $name member of object of class $class" );
}

sub open
{
    my $self = shift;
    $self->loadMonitor();
    use LWP::UserAgent;
    $self->{ua} = LWP::UserAgent->new;
#    $self->{ua}->agent( "ZoneMinder Control Agent/".ZM_VERSION );
    $self->{ua}->agent( "ZoneMinder Control Agent" );
    $self->{state} = 'open';
}

sub close
{
    my $self = shift;
    $self->{state} = 'closed';
}

sub sendCmd
{
    my $self = shift;
    my $cmd = shift;
    my $result = undef;
    my $req = HTTP::Request->new( GET=>"http://".$self->{Monitor}->{ControlAddress}."/$cmd" );

    my $res = $self->{ua}->request($req);
    if ( $res->is_success ) $result = $res->decoded_content;
    else Error( "Error check failed: '".$res->status_line()."'" );

    return( $result );
}

# Reset camera
sub reset
{
    my $self = shift;
    Debug( "Camera Reset" );
    my $cmd = "cgi-bin/hi3510/sysreboot.cgi";
    $self->sendCmd( $cmd );
}

# Reboot camera
sub reboot
{
    my $self = shift;
    Debug( "Camera Reboot" );
    my $cmd = "cgi-bin/hi3510/sysreboot.cgi";
    $self->sendCmd( $cmd );
}


# Flip image on vertically
sub wake
{
    my $self = shift;
    Debug( "Flip on" );
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-flip=on";
    $self->sendCmd( $cmd );
}


# Flip image off vertically
sub sleep
{
    my $self = shift;
    Debug( "Flip off" );
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-flip=off";
    $self->sendCmd( $cmd );
}

# Move up IPCAM
sub moveConUp
{
    my $self = shift;
    my $params = shift;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=up";
    $self->sendCmd( $cmd );
    my $autostop = $self->getParam( $params, 'autostop', 0 );
    if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
    {
        usleep( $self->{Monitor}->{AutoStopTimeout} );
        $self->moveStop( $params );
    }
    else
    {
    $self->moveStop( $params );
    }
}

# Move down IPCAM
sub moveConDown
{
    my $self = shift;
    my $params = shift;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=down";
    $self->sendCmd( $cmd );
    my $autostop = $self->getParam( $params, 'autostop', 0 );
    if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
    {
        usleep( $self->{Monitor}->{AutoStopTimeout} );
        $self->moveStop( $params );
    }
    else
    {
    $self->moveStop( $params );
    }
}

# Move Right IPCAM
sub moveConRight
{
    my $self = shift;
    my $params = shift;
    Debug( "Move Right" );
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=1&-speed=10&-act=right";
    $self->sendCmd( $cmd );
    my $autostop = $self->getParam( $params, 'autostop', 0 );
    if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
    {
        usleep( $self->{Monitor}->{AutoStopTimeout} );
        $self->moveStop( $params );
    }
    else
    {
    $self->moveStop( $params );
    }
}

# Move left IPCAM
sub moveConLeft
{
    my $self = shift;
    my $params = shift;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=1&-speed=10&-act=left";
    $self->sendCmd( $cmd );
    my $autostop = $self->getParam( $params, 'autostop', 0 );
    if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
    {
        usleep( $self->{Monitor}->{AutoStopTimeout} );
        $self->moveStop( $params );
    }
    else
    {
    $self->moveStop( $params );
    }
}

# The camera can not move diagonally, so we will implement those movements in the next 4 subroutines:
sub moveConUpLeft
{
    my $self = shift;
    my $params = shift;
    my $loopcount=int($self->{Monitor}->{AutoStopTimeout}/$loopfactor);
    my $autostop = $self->getParam( $params, 'autostop', 0 );
    if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
    {
        while ( $loopcount  )
        {
             $loopcount--;
             my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=up";
             $self->sendCmd( $cmd );
             my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=left";
             $self->sendCmd( $cmd );

         }
        $self->moveStop( $params );
    }
}


sub moveConUpRight
{
   my $self = shift;
   my $params = shift;
   my $loopcount=int($self->{Monitor}->{AutoStopTimeout}/$loopfactor);
   my $autostop = $self->getParam( $params, 'autostop', 0 );
   if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
   {
         while ( $loopcount  )
         {
             $loopcount--;
             my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=up";
             $self->sendCmd( $cmd );
             my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=right";
             $self->sendCmd( $cmd );
         }
            $self->moveStop( $params );
  }
}


sub moveConDownRight
{
    my $self = shift;
    my $params = shift;
    my $loopcount=int($self->{Monitor}->{AutoStopTimeout}/$loopfactor);
    my $autostop = $self->getParam( $params, 'autostop', 0 );
    if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
    {
        while ( $loopcount  )
        {
            $loopcount--;
            my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=down";
            $self->sendCmd( $cmd );
            my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=right";
            $self->sendCmd( $cmd );
        }
        $self->moveStop( $params );
    }
}

sub moveConDownLeft
{
    my $self = shift;
    my $params = shift;
    my $loopcount=int($self->{Monitor}->{AutoStopTimeout}/$loopfactor);
    my $autostop = $self->getParam( $params, 'autostop', 0 );
    if ( $autostop && $self->{Monitor}->{AutoStopTimeout} )
    {
        while ( $loopcount  )
        {
            $loopcount--;
            my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=down";
            $self->sendCmd( $cmd );
            my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=left";
            $self->sendCmd( $cmd );
        }
        $self->moveStop( $params );
    }
}

sub moveStop
{
    my $self = shift;
    print("autostop\n");
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=ptzctrl&-step=0&-speed=10&-act=stop";
    $self->sendCmd( $cmd );
}


sub getDisplayAttr
{
    my $self = shift;
    my $param = shift;
    my $cmdget = "cgi-bin/hi3510/param.cgi?cmd=getvdisplayattr&-brightness";
    my $resp = $self->sendCmd( $cmdget );
    my @buffer=split(';',$resp);
    my $response=$buffer[$param];
    my @buffer=split('"',$response);
    my $response=$buffer[1];
    return ($response);
}

# presetHome is used to normalize the brightness/contrast/hue/saturation values
sub presetHome
{
    my $self = shift;
    Debug( "Home Preset" );
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-brightness=50&-contrast=50&-saturation=50&-hue=50";
    $self->sendCmd( $cmd );
}

# Set Preset
sub presetSet
{
    my $self = shift;
    my $params = shift;
    my $preset = $self->getParam( $params, 'preset' );
    Debug( "Set Preset $preset " );
    my $cmd = "cgi-bin/hi3510/preset.cgi?-act=set&-status=1&-number=$preset";
    $self->sendCmd( $cmd );
}

# Goto Preset
sub presetGoto
{
    my $self = shift;
    my $params = shift;
    my $preset = $self->getParam( $params, 'preset' );
    Debug( "Goto Preset $preset" );
    my $cmd = "cgi-bin/hi3510/preset.cgi?-act=goto&-number=$preset";
    $self->sendCmd( $cmd );
}


# Contrast control
sub whiteAbsIn
{
    my $self = shift;
    my $params = shift;
    Debug( "Contrast up" );
    my $dvalue=$self->getDisplayAttr(6);
    if ( $dvalue < 100 )
    {
    $dvalue=$dvalue+5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-contrast=$dvalue";
    $self->sendCmd( $cmd );
    }
}

# Contrast control
sub whiteAbsOut
{
    my $self = shift;
    my $params = shift;
    Debug( "Contrast down" );
    my $dvalue=$self->getDisplayAttr(6);
    if ( $dvalue > 0 )
    {
    $dvalue=$dvalue-5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-contrast=$dvalue";
    $self->sendCmd( $cmd );
    }
}

# Brightness control
sub irisAbsOpen
{
    my $self = shift;
    my $params = shift;
    Debug( "Brightness up" );
    my $dvalue=$self->getDisplayAttr(4);
    if ( $dvalue < 100 )
    {
    $dvalue=$dvalue+5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setimageattr&-brightness=$dvalue";
    $self->sendCmd( $cmd );
    }
}

# Brightness control
sub irisAbsClose
{
    my $self = shift;
    my $params = shift;
    Debug( "Brightness down" );
    my $dvalue=$self->getDisplayAttr(4);
    if ( $dvalue > 0 )
    {
    $dvalue=$dvalue-5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setimageattr&-brightness=$dvalue";
    $self->sendCmd( $cmd );
    }
}


# Saturation control
sub zoomAbsTele
{
    my $self = shift;
    my $params = shift;
    Debug( "Saturation up" );
    my $dvalue=$self->getDisplayAttr(5);
    if ( $dvalue < 100 )
    {
    $dvalue=$dvalue+5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-saturation=$dvalue";
    $self->sendCmd( $cmd );
    }
}

# Saturation control
sub zoomAbsWide
{
    my $self = shift;
    my $params = shift;
    Debug( "Saturation down" );
    my $dvalue=$self->getDisplayAttr(5);
    if ( $dvalue > 0 )
    {
    $dvalue=$dvalue-5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-saturation=$dvalue";
    $self->sendCmd( $cmd );
    }
}

# Hue control
sub focusAbsNear
{
    my $self = shift;
    my $params = shift;
    Debug( "Hue up" );
    my $dvalue=$self->getDisplayAttr(7);
    if ( $dvalue < 100 )
    {
    $dvalue=$dvalue+5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-hue=$dvalue";
    $self->sendCmd( $cmd );
    }
}

# Hue control
sub focusAbsFar
{
    my $self = shift;
    my $params = shift;
    Debug( "Hue down" );
    my $dvalue=$self->getDisplayAttr(7);
    if ( $dvalue > 0 )
    {
    $dvalue=$dvalue-5;
    my $cmd = "cgi-bin/hi3510/param.cgi?cmd=setvdisplayattr&-hue=$dvalue";
    $self->sendCmd( $cmd );
    }
}

1;
