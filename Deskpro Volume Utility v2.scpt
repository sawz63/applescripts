FasdUAS 1.101.10   ��   ��    k             l     ��  ��     @osa-lang:AppleScript     � 	 	 * @ o s a - l a n g : A p p l e S c r i p t   
  
 l     ��������  ��  ��        l          x     ��  ��    1      ��
�� 
ascr  �� ��
�� 
minv  m         �    2 . 4��    L F Yosemite (10.10) or later -- tested on OS X 12.3 Montery 1 April 2022     �   �   Y o s e m i t e   ( 1 0 . 1 0 )   o r   l a t e r   - -   t e s t e d   o n   O S   X   1 2 . 3   M o n t e r y   1   A p r i l   2 0 2 2      x    �� ����    2  	 ��
�� 
osax��        l     ��������  ��  ��        l      ��  ��   D>

Developed by: Pete Sawyer 
Version v0.1.1
  
One of the things I didn't like about the Deskpro was not being able to select different volume levels for Mactone, in call and PC individually. I was constantly reaching over to change the volume settings. My in call volume was too loud for the ringtone and PC output, the ringtone volume I wanted was too low for in call volume, etc... So I created this script to change the volume from my keyboard. It uses xml via the https API to get status and send commands to the Deskpro. 
 
https://www.cisco.com/c/dam/en/us/td/docs/telepresence/endpoint/ce915/collaboration-endpoint-software-api-reference-guide-ce915.pdf 
 
This script is to be used at your own discretion. I use a program called "FastScripts" to assign a keyboard shortcut to run the script. I can simply hit my keyboard combination, select the volume I want from the pre-assigned values for "Mac"  "Call" or "Mute" and the script will adjust the volume on the Deskpro. 
Fastscripts can be downloaded from the App Store or a free version limited to 10 keyboard shortcuts is available https://redsweater.com/fastscripts/ 

The script works for my purposes to change the volume, answer a call, and control an "in call" status light outside my office door from a keyboard shortcut on my Mac. 


(* PREREQUISITES *)

You must have access to the Deskpro in order for the script to connect. This can be enabled via the ACE Dashboard under devices at ace.cisco.com Select enable admin access, connect to the deskpro and create a user. 

Your Mac must be able to connect to the Deskpro, some network scenarios may not work, i.e. Deskpro on personal network, Mac on CVO or VPN. 

Set the following variables to match your system requirements. "theMacVolume, theCallVolume, and theMuteVolume" 
 
On first run the script will prompt you for the following: 
 1. Your Deskpro IP Address or hostname. If you provide the hostname it must 
 	be DNS resolvable, otherwise simply provide the IP address. 
 2. The Deskpro username that has permission to connect and make changes to the Deskpro. The script will store the username 
	 in com.cisco.Deskpro.<username>
 3. The deskpro password. This is the password for you deskpro user. The password is used along with our username to create a base64url hash that is stored in the keychain and used by the script to connect to the deskpro.
 4. When in a call the script will allow you to change between microphone muted and unmuted. It will also allow you to disconnect the call. 
 5. When not in a call the script will allow you to change between the pre-defined volume settings. If you select "yes" you will be prompted for the prerequisites to control the TP-Link device. You will need your KASA KEY and the Device IDs. 
 6. The script will ask if you want to control an TP-Link smart plug(s). This can be used as an "In Call" indicator. The use case I have for this is a TP-Link plug outside my office door in the hallway. I have a small red night light plugged into the TP-Link. When I'm in a call it turns on, when I disconnect (with the script) it turns off. Or it will turn off when not in a call and you run the script to change the volume setting.
	
	(* KASA PLUG CONTROL *) 
	(* Changed to local direct control via python-kasa *)
	(* Requires python-kasa be installed on your system https://python-kasa.readthedocs.io/en/latest/index.html *)
     �    | 
 
 D e v e l o p e d   b y :   P e t e   S a w y e r   
 V e r s i o n   v 0 . 1 . 1 
     
 O n e   o f   t h e   t h i n g s   I   d i d n ' t   l i k e   a b o u t   t h e   D e s k p r o   w a s   n o t   b e i n g   a b l e   t o   s e l e c t   d i f f e r e n t   v o l u m e   l e v e l s   f o r   M a c t o n e ,   i n   c a l l   a n d   P C   i n d i v i d u a l l y .   I   w a s   c o n s t a n t l y   r e a c h i n g   o v e r   t o   c h a n g e   t h e   v o l u m e   s e t t i n g s .   M y   i n   c a l l   v o l u m e   w a s   t o o   l o u d   f o r   t h e   r i n g t o n e   a n d   P C   o u t p u t ,   t h e   r i n g t o n e   v o l u m e   I   w a n t e d   w a s   t o o   l o w   f o r   i n   c a l l   v o l u m e ,   e t c . . .   S o   I   c r e a t e d   t h i s   s c r i p t   t o   c h a n g e   t h e   v o l u m e   f r o m   m y   k e y b o a r d .   I t   u s e s   x m l   v i a   t h e   h t t p s   A P I   t o   g e t   s t a t u s   a n d   s e n d   c o m m a n d s   t o   t h e   D e s k p r o .   
   
 h t t p s : / / w w w . c i s c o . c o m / c / d a m / e n / u s / t d / d o c s / t e l e p r e s e n c e / e n d p o i n t / c e 9 1 5 / c o l l a b o r a t i o n - e n d p o i n t - s o f t w a r e - a p i - r e f e r e n c e - g u i d e - c e 9 1 5 . p d f   
   
 T h i s   s c r i p t   i s   t o   b e   u s e d   a t   y o u r   o w n   d i s c r e t i o n .   I   u s e   a   p r o g r a m   c a l l e d   " F a s t S c r i p t s "   t o   a s s i g n   a   k e y b o a r d   s h o r t c u t   t o   r u n   t h e   s c r i p t .   I   c a n   s i m p l y   h i t   m y   k e y b o a r d   c o m b i n a t i o n ,   s e l e c t   t h e   v o l u m e   I   w a n t   f r o m   t h e   p r e - a s s i g n e d   v a l u e s   f o r   " M a c "     " C a l l "   o r   " M u t e "   a n d   t h e   s c r i p t   w i l l   a d j u s t   t h e   v o l u m e   o n   t h e   D e s k p r o .   
 F a s t s c r i p t s   c a n   b e   d o w n l o a d e d   f r o m   t h e   A p p   S t o r e   o r   a   f r e e   v e r s i o n   l i m i t e d   t o   1 0   k e y b o a r d   s h o r t c u t s   i s   a v a i l a b l e   h t t p s : / / r e d s w e a t e r . c o m / f a s t s c r i p t s /   
 
 T h e   s c r i p t   w o r k s   f o r   m y   p u r p o s e s   t o   c h a n g e   t h e   v o l u m e ,   a n s w e r   a   c a l l ,   a n d   c o n t r o l   a n   " i n   c a l l "   s t a t u s   l i g h t   o u t s i d e   m y   o f f i c e   d o o r   f r o m   a   k e y b o a r d   s h o r t c u t   o n   m y   M a c .   
 
 
 ( *   P R E R E Q U I S I T E S   * ) 
 
 Y o u   m u s t   h a v e   a c c e s s   t o   t h e   D e s k p r o   i n   o r d e r   f o r   t h e   s c r i p t   t o   c o n n e c t .   T h i s   c a n   b e   e n a b l e d   v i a   t h e   A C E   D a s h b o a r d   u n d e r   d e v i c e s   a t   a c e . c i s c o . c o m   S e l e c t   e n a b l e   a d m i n   a c c e s s ,   c o n n e c t   t o   t h e   d e s k p r o   a n d   c r e a t e   a   u s e r .   
 
 Y o u r   M a c   m u s t   b e   a b l e   t o   c o n n e c t   t o   t h e   D e s k p r o ,   s o m e   n e t w o r k   s c e n a r i o s   m a y   n o t   w o r k ,   i . e .   D e s k p r o   o n   p e r s o n a l   n e t w o r k ,   M a c   o n   C V O   o r   V P N .   
 
 S e t   t h e   f o l l o w i n g   v a r i a b l e s   t o   m a t c h   y o u r   s y s t e m   r e q u i r e m e n t s .   " t h e M a c V o l u m e ,   t h e C a l l V o l u m e ,   a n d   t h e M u t e V o l u m e "   
   
 O n   f i r s t   r u n   t h e   s c r i p t   w i l l   p r o m p t   y o u   f o r   t h e   f o l l o w i n g :   
   1 .   Y o u r   D e s k p r o   I P   A d d r e s s   o r   h o s t n a m e .   I f   y o u   p r o v i d e   t h e   h o s t n a m e   i t   m u s t   
   	 b e   D N S   r e s o l v a b l e ,   o t h e r w i s e   s i m p l y   p r o v i d e   t h e   I P   a d d r e s s .   
   2 .   T h e   D e s k p r o   u s e r n a m e   t h a t   h a s   p e r m i s s i o n   t o   c o n n e c t   a n d   m a k e   c h a n g e s   t o   t h e   D e s k p r o .   T h e   s c r i p t   w i l l   s t o r e   t h e   u s e r n a m e   
 	   i n   c o m . c i s c o . D e s k p r o . < u s e r n a m e > 
   3 .   T h e   d e s k p r o   p a s s w o r d .   T h i s   i s   t h e   p a s s w o r d   f o r   y o u   d e s k p r o   u s e r .   T h e   p a s s w o r d   i s   u s e d   a l o n g   w i t h   o u r   u s e r n a m e   t o   c r e a t e   a   b a s e 6 4 u r l   h a s h   t h a t   i s   s t o r e d   i n   t h e   k e y c h a i n   a n d   u s e d   b y   t h e   s c r i p t   t o   c o n n e c t   t o   t h e   d e s k p r o . 
   4 .   W h e n   i n   a   c a l l   t h e   s c r i p t   w i l l   a l l o w   y o u   t o   c h a n g e   b e t w e e n   m i c r o p h o n e   m u t e d   a n d   u n m u t e d .   I t   w i l l   a l s o   a l l o w   y o u   t o   d i s c o n n e c t   t h e   c a l l .   
   5 .   W h e n   n o t   i n   a   c a l l   t h e   s c r i p t   w i l l   a l l o w   y o u   t o   c h a n g e   b e t w e e n   t h e   p r e - d e f i n e d   v o l u m e   s e t t i n g s .   I f   y o u   s e l e c t   " y e s "   y o u   w i l l   b e   p r o m p t e d   f o r   t h e   p r e r e q u i s i t e s   t o   c o n t r o l   t h e   T P - L i n k   d e v i c e .   Y o u   w i l l   n e e d   y o u r   K A S A   K E Y   a n d   t h e   D e v i c e   I D s .   
   6 .   T h e   s c r i p t   w i l l   a s k   i f   y o u   w a n t   t o   c o n t r o l   a n   T P - L i n k   s m a r t   p l u g ( s ) .   T h i s   c a n   b e   u s e d   a s   a n   " I n   C a l l "   i n d i c a t o r .   T h e   u s e   c a s e   I   h a v e   f o r   t h i s   i s   a   T P - L i n k   p l u g   o u t s i d e   m y   o f f i c e   d o o r   i n   t h e   h a l l w a y .   I   h a v e   a   s m a l l   r e d   n i g h t   l i g h t   p l u g g e d   i n t o   t h e   T P - L i n k .   W h e n   I ' m   i n   a   c a l l   i t   t u r n s   o n ,   w h e n   I   d i s c o n n e c t   ( w i t h   t h e   s c r i p t )   i t   t u r n s   o f f .   O r   i t   w i l l   t u r n   o f f   w h e n   n o t   i n   a   c a l l   a n d   y o u   r u n   t h e   s c r i p t   t o   c h a n g e   t h e   v o l u m e   s e t t i n g . 
 	 
 	 ( *   K A S A   P L U G   C O N T R O L   * )   
 	 ( *   C h a n g e d   t o   l o c a l   d i r e c t   c o n t r o l   v i a   p y t h o n - k a s a   * ) 
 	 ( *   R e q u i r e s   p y t h o n - k a s a   b e   i n s t a l l e d   o n   y o u r   s y s t e m   h t t p s : / / p y t h o n - k a s a . r e a d t h e d o c s . i o / e n / l a t e s t / i n d e x . h t m l   * ) 
   ! " ! l     ��������  ��  ��   "  # $ # l      �� % &��   %   INSTRUCTIONS     & � ' '    I N S T R U C T I O N S   $  ( ) ( l     ��������  ��  ��   )  * + * l      �� , -��   , L F USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND     - � . . �   U S E D   F O R   T E S T I N G   T O T A L   T I M E   T O   E X E C U T E   T H E   S C R I P T   T O   T H E   M I L L I S E C O N D   +  / 0 / l      �� 1 2��   1 P J Lines at the end of the script also have to be commented out or included     2 � 3 3 �   L i n e s   a t   t h e   e n d   o f   t h e   s c r i p t   a l s o   h a v e   t o   b e   c o m m e n t e d   o u t   o r   i n c l u d e d   0  4 5 4 l     �� 6 7��   6 H Bset mgRightNow to "perl -e 'use Time::HiRes qw(time); print time'"    7 � 8 8 � s e t   m g R i g h t N o w   t o   " p e r l   - e   ' u s e   T i m e : : H i R e s   q w ( t i m e ) ;   p r i n t   t i m e ' " 5  9 : 9 l     �� ; <��   ; / )set mgStart to do shell script mgRightNow    < � = = R s e t   m g S t a r t   t o   d o   s h e l l   s c r i p t   m g R i g h t N o w :  > ? > l     ��������  ��  ��   ?  @ A @ l      �� B C��   B 4 . ############################################     C � D D \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   A  E F E l      �� G H��   G 8 2 ################ USER VARIABLES ################     H � I I d   # # # # # # # # # # # # # # # #   U S E R   V A R I A B L E S   # # # # # # # # # # # # # # # #   F  J K J l      �� L M��   L 4 . ############################################     M � N N \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   K  O P O l      �� Q R��   Q ` Z set different volume levels to match your specific requirements by changing these values     R � S S �   s e t   d i f f e r e n t   v o l u m e   l e v e l s   t o   m a t c h   y o u r   s p e c i f i c   r e q u i r e m e n t s   b y   c h a n g i n g   t h e s e   v a l u e s   P  T U T l     V���� V r      W X W m      Y Y � Z Z  2 5 X o      ���� 0 themacvolume theMacVolume��  ��   U  [ \ [ l    ]���� ] r     ^ _ ^ m     ` ` � a a  6 0 _ o      ���� 0 thecallvolume theCallVolume��  ��   \  b c b l    d���� d r     e f e m    	 g g � h h  0 f o      ���� 0 themutevolume theMuteVolume��  ��   c  i j i l     ��������  ��  ��   j  k l k l      �� m n��   m�� prefsName is the variable for preference panes and keychain naming for user preferences and securityfor example if set to TESTME the preference pane would be com.cisco.TESTME and the keychain entry would be TESTME.<DESKPRO_USER> . You can safely change this to anything you want the preferences and keychain to show up as. If you do not set this variable the default of the script name will be used     n � o o    p r e f s N a m e   i s   t h e   v a r i a b l e   f o r   p r e f e r e n c e   p a n e s   a n d   k e y c h a i n   n a m i n g   f o r   u s e r   p r e f e r e n c e s   a n d   s e c u r i t y f o r   e x a m p l e   i f   s e t   t o   T E S T M E   t h e   p r e f e r e n c e   p a n e   w o u l d   b e   c o m . c i s c o . T E S T M E   a n d   t h e   k e y c h a i n   e n t r y   w o u l d   b e   T E S T M E . < D E S K P R O _ U S E R >   .   Y o u   c a n   s a f e l y   c h a n g e   t h i s   t o   a n y t h i n g   y o u   w a n t   t h e   p r e f e r e n c e s   a n d   k e y c h a i n   t o   s h o w   u p   a s .   I f   y o u   d o   n o t   s e t   t h i s   v a r i a b l e   t h e   d e f a u l t   o f   t h e   s c r i p t   n a m e   w i l l   b e   u s e d   l  p q p l    r���� r r     s t s m     u u � v v , D e s k p r o   V o l u m e   U t i l i t y t o      ���� 0 	prefsname 	prefsName��  ��   q  w x w l   ! y���� y Z    ! z {���� z =    | } | o    ���� 0 	prefsname 	prefsName } m     ~ ~ �     { r     � � � c     � � � n    � � � 1    ��
�� 
pnam �  f     � m    ��
�� 
ctxt � o      ���� 0 	prefsname 	prefsName��  ��  ��  ��   x  � � � l     ��������  ��  ��   �  � � � l      �� � ���   � 4 . ############################################     � � � � \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   �  � � � l      �� � ���   � 9 3 ############# END OF USER VARIABLES #############     � � � � f   # # # # # # # # # # # # #   E N D   O F   U S E R   V A R I A B L E S   # # # # # # # # # # # # #   �  � � � l      �� � ���   � 4 . ############################################     � � � � \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   �  � � � l     ��������  ��  ��   �  � � � l      �� � ���   �   NO CHANGES BELOW HERE     � � � � .   N O   C H A N G E S   B E L O W   H E R E   �  � � � l     ��������  ��  ��   �  � � � l      �� � ���   � 7 1 Make variables globally available to the script     � � � � b   M a k e   v a r i a b l e s   g l o b a l l y   a v a i l a b l e   t o   t h e   s c r i p t   �  � � � l     ��������  ��  ��   �  � � � j    �� ��� 0 
mutestatus 
muteStatus � m     � � � � �   �  � � � j    �� ��� 0 thecurrvolume theCurrVolume � m     � � � � �   �  � � � j    �� ��� 0 answeredstate answeredState � m     � � � � �   �  � � � j    �� ��� 0 callduration callDuration � m     � � � � �   �  � � � j    !�� ��� 0 	thevolume 	theVolume � m      � � � � �   �  � � � j   " $�� ��� 0 
callstatus 
callStatus � m   " # � � � � �   �  � � � j   % )�� ��� 0 
thevolmute 
theVolMute � m   % ( � � � � �   �  � � � j   * .�� ��� 0 thecleantext theCleanText � m   * - � � � � �   �  � � � l     ��������  ��  ��   �  � � � p   / / � � ������ 0 thehost theHost��   �  � � � p   / / � � ������ 0 theend theEnd��   �  � � � p   / / � � ������ 0 theuser theUser��   �  � � � p   / / � � ������ 0 thepwd thePwd��   �  � � � p   / / � � ������ 0 themacvolume theMacVolume��   �  � � � p   / / � � ������ 0 thecallvolume theCallVolume��   �  � � � p   / / � � ������ 0 themutevolume theMuteVolume��   �  � � � p   / / � � ������ 0 badpwdchars BadPWDchars��   �  � � � p   / / � � ������ 0 trypwd tryPWD��   �  � � � p   / / � � ������ 0 	prefsname 	prefsName��   �  � � � p   / / � � ������ 0 micstate micState��   �  � � � p   / / � � ������ 0 
autoanswer 
AutoAnswer��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � p   / / � � ������ 
0 tplink  ��   �  � � � p   / / � � ������ "0 mytplinkdevices myTPLinkDevices��   �  �  � p   / / ������  0 newkasadevices newKasaDevices��     p   / / ������ 0 myuuidv4 myUUIDv4��    p   / / ������ 0 mybase64url myBase64Url��   	 l     �������  ��  �  	 

 p   / / �~�}�~ 0 getcmd getCmd�}    p   / / �|�{�| 0 grep_for  �{    p   / / �z�y�z 0 thevar theVar�y    p   / / �x�w�x 0 	the2ndvar 	the2ndVar�w    p   / / �v�u�v 0 
mycmdstart 
myCmdStart�u    p   / / �t�s�t 0 mycmdend myCmdEnd�s    p   / / �r�q�r 0 mycmd myCmd�q     p   / /!! �p�o�p 0 my2ndcmd my2ndCmd�o    "#" p   / /$$ �n�m�n 0 postcmd postCmd�m  # %&% p   / /'' �l�k�l 0 	currvalue 	currValue�k  & ()( p   / /** �j�i�j 0 selfcert  �i  ) +,+ l     �h�g�f�h  �g  �f  , -.- l  " //�e�d/ r   " /010 J   " +22 343 m   " #55 �66  !4 787 m   # $99 �::  [8 ;<; m   $ %== �>>  ]< ?@? m   % &AA �BB  {@ C�cC m   & 'DD �EE  }�c  1 o      �b�b 0 badpwdchars BadPWDchars�e  �d  . FGF l  0 6H�a�`H r   0 6IJI J   0 2�_�_  J o      �^�^ 0 my2ndcmd my2ndCmd�a  �`  G KLK l     �]�\�[�]  �\  �[  L MNM l     �ZOP�Z  O . ( Walk user though enabling UI automation   P �QQ P   W a l k   u s e r   t h o u g h   e n a b l i n g   U I   a u t o m a t i o nN RSR l  7 BT�Y�XT r   7 BUVU c   7 >WXW n   7 <YZY 1   : <�W
�W 
pnamZ m   7 :�V
�V misccuraX m   < =�U
�U 
ctxtV o      �T�T 
0 myname  �Y  �X  S [\[ l  C5]�S�R] Z   C5^�Q�P_^ =  C J`a` o   C F�O�O 
0 myname  a m   F Ibb �cc " r u n m e _ i n s t a l l _ D V U�Q  �P  _ k   Q5dd efe Z   Q fgh�N�Mg =  Q Xiji o   Q T�L�L 
0 myname  j m   T Wkk �ll  o s a s c r i p th r   [ bmnm m   [ ^oo �pp  S c r i p t   M e n un o      �K�K 
0 myname  �N  �M  f qrq l  g g�J�I�H�J  �I  �H  r sts O  g wuvu r   m vwxw 1   m r�G
�G 
uienx o      �F�F ,0 isuiscriptingenabled isUIScriptingEnabledv m   g jyy�                                                                                  sevs  alis    T  BigSurHD                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    B i g S u r H D  -System/Library/CoreServices/System Events.app   / ��  t z�Ez Z   x5{|�D�C{ =   x }}~} o   x {�B�B ,0 isuiscriptingenabled isUIScriptingEnabled~ m   { |�A
�A boovfals| O   �1� k   �0�� ��� I  � ��@�?�>
�@ .miscactvnull��� ��� null�?  �>  � ��� I  � ��=��
�= .sysonotfnull��� ��� TEXT� m   � ��� ��� V P l e a s e   f o l l o w   i n s t r u c t i o n s   w h e n   t h e y   a p p e a r� �<��
�< 
appr� c   � ���� l  � ���;�:� n   � ���� 1   � ��9
�9 
pnam�  f   � ��;  �:  � m   � ��8
�8 
ctxt� �7��6
�7 
subt� m   � ��� ��� R L o a d i n g   S e c u r i t y   &   P r i v a c y   P r e f e r e n c e s . . .�6  � ��� r   � ���� 4   � ��5�
�5 
xppb� m   � ��� ��� : c o m . a p p l e . p r e f e r e n c e . s e c u r i t y� 1   � ��4
�4 
xpcp� ��� O  � ���� I  � ��3��2
�3 .miscmvisnull���     ****� 4   � ��1�
�1 
xppa� m   � ��� ��� * P r i v a c y _ A c c e s s i b i l i t y�2  � 1   � ��0
�0 
xpcp� ��� l  � ��/���/  � : 4 Activate again so the dialog box will appear on top   � ��� h   A c t i v a t e   a g a i n   s o   t h e   d i a l o g   b o x   w i l l   a p p e a r   o n   t o p� ��� I  � ��.�-�,
�. .miscactvnull��� ��� null�-  �,  � ��� I  �*�+��
�+ .sysodlogaskr        TEXT� b   �
��� b   ���� b   ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� | Y o u r   s y s t e m   n e e d s   a   o n e - t i m e   c o n f i g u r a t i o n   t o   r u n   t h i s   s c r i p t .� o   � ��*
�* 
ret � o   � ��)
�) 
ret � m   � ��� ��� x I n   " S y s t e m   P r e f e r e n c e s . . .   - >   S e c u r i t y   &   P r i v a c y   - >   P r i v a c y " :� o   � ��(
�( 
ret � o   � ��'
�' 
ret � m   � ��� ��� T 1 .   U n l o c k   " C l i c k   t h e   l o c k   t o   m a k e   c h a n g e s "� o   � ��&
�& 
ret � m   � ��� ��� > 2 .   S e l e c t   " C l i c k   A c c e s s i b i l i t y "� o   � ��%
�% 
ret � m   � ��� ��� : 3 .   S e l e c t   c h e c k b o x   n e x t   t o :   "� o   � ��$�$ 
0 myname  � m   ��� ���  "� o  �#
�# 
ret � m  	�� ��� @ 4 .   R e - r u n   t h e   s c r i p t   t o   p r o c e e d .� �"��
�" 
appr� n  ��� 1  �!
�! 
pnam�  f  � � ��
�  
btns� J  �� ��� m  �� ���  O K�  � ���
� 
cbtn� m  �� ���  O K� ���
� 
disp� m  !$�
� stic   �  � ��� I +0���
� .aevtquitnull��� ��� null�  �  �  � m   � ����                                                                                  sprf  alis    X  BigSurHD                       BD ����System Preferences.app                                         ����            ����  
 cu             Applications  -/:System:Applications:System Preferences.app/   .  S y s t e m   P r e f e r e n c e s . a p p    B i g S u r H D  *System/Applications/System Preferences.app  / ��  �D  �C  �E  �S  �R  \ ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l 6>���� I  6>���� 0 get_prereqs get_PreReqs� ��� m  7:�� ���  g e t P r e f s�  �  �  �  � ��� l     ��
�	�  �
  �	  � ��� l      ����  � � �If Auto Answer was selected check to see if there is an incoming call, If so answer it; check if connected or in some state of connecting; set the tplink to the correct state, set the volume to in call level   � ���� I f   A u t o   A n s w e r   w a s   s e l e c t e d   c h e c k   t o   s e e   i f   t h e r e   i s   a n   i n c o m i n g   c a l l ,   I f   s o   a n s w e r   i t ;   c h e c k   i f   c o n n e c t e d   o r   i n   s o m e   s t a t e   o f   c o n n e c t i n g ;   s e t   t h e   t p l i n k   t o   t h e   c o r r e c t   s t a t e ,   s e t   t h e   v o l u m e   t o   i n   c a l l   l e v e l� ��� l     ����  � # on get_AutoAnswer(AutoAnswer)   � ��� : o n   g e t _ A u t o A n s w e r ( A u t o A n s w e r )�    l      ��   z t check to see if the Deskpro is ringing, if so answer it and set the tplink  to on, set the volume to in call level     � �   c h e c k   t o   s e e   i f   t h e   D e s k p r o   i s   r i n g i n g ,   i f   s o   a n s w e r   i t   a n d   s e t   t h e   t p l i n k     t o   o n ,   s e t   t h e   v o l u m e   t o   i n   c a l l   l e v e l    l ?��� Z  ?�	
� = ?F o  ?B�� 0 
autoanswer 
AutoAnswer m  BE �  Y e s	 k  I:  Q  I4 k  L#  I  LQ�� ��� 0 get_xml  �   ��   �� Z  R# E  R[ o  RW���� 0 
callstatus 
callStatus m  WZ �    R i n g i n g k  ^�!! "#" r  ^e$%$ m  ^a&& �''  % o      ���� 0 thevar theVar# ()( r  fk*+* o  fg���� 0 thecallvolume theCallVolume+ o      ���� 0 	the2ndvar 	the2ndVar) ,-, r  lu./. m  lo00 �11  1/ o      ���� 0 
callstatus 
callStatus- 232 I  v~��4���� 0 
set_tplink  4 5��5 m  wz66 �77  o n��  ��  3 898 r  �:;: J  �<< =>= m  �?? �@@  C o m m a n d> ABA m  ��CC �DD  C a l lB E��E m  ��FF �GG  A c c e p t��  ; o      ���� 0 mycmd myCmd9 HIH r  ��JKJ J  ��LL MNM m  ��OO �PP  C o m m a n dN QRQ m  ��SS �TT 
 A u d i oR UVU m  ��WW �XX  V o l u m eV YZY m  ��[[ �\\ $ S e t   c o m m a n d = " T r u e "Z ]��] m  ��^^ �__ 
 L e v e l��  K o      ���� 0 my2ndcmd my2ndCmdI `a` I  ���������� 0 post_cmd  ��  ��  a b��b L  ������  ��   cdc G  ��efe E  ��ghg o  ������ 0 
callstatus 
callStatush m  ��ii �jj  C o n n e c t i n gf E  ��klk o  ������ 0 
callstatus 
callStatusl m  ��mm �nn  D i a l l i n gd opo k  ��qq rsr I  ����t���� 0 
set_tplink  t u��u m  ��vv �ww  o n��  ��  s xyx r  ��z{z o  ������ 0 thecallvolume theCallVolume{ o      ���� 0 thevar theVary |}| r  ��~~ J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  V o l u m e� ��� m  ���� ��� $ S e t   c o m m a n d = " T r u e "� ���� m  ���� ��� 
 L e v e l��   o      ���� 0 mycmd myCmd} ��� I  ���������� 0 post_cmd  ��  ��  � ��� L  ������  � ���� l ��������  �  	set callStatus to "1"   � ��� , 	 s e t   c a l l S t a t u s   t o   " 1 "��  p ��� E  ��� o  ���� 0 
callstatus 
callStatus� m  
�� ���  C o n n e c t e d� ���� r  ��� m  �� ���  1� o      ���� 0 
callstatus 
callStatus��   r  #��� m  �� ���  0� o      ���� 0 
callstatus 
callStatus��   R      ������
�� .ascrerr ****      � ****��  ��   r  +4��� m  +.�� ���  0� o      ���� 0 
callstatus 
callStatus ���� I  5:�������� 0 
get_volume 
get_Volume��  ��  ��  
 ��� = =D��� o  =@���� 0 
autoanswer 
AutoAnswer� m  @C�� ���  N o� ���� k  G��� ��� I  GL�������� 0 get_xml  ��  ��  � ��� Z  M�������� = MT��� o  MP���� 
0 tplink  � m  PS�� ���  1� Q  W����� Z  Z������� G  Z���� G  Z}��� G  Zo��� E  Za��� o  Z]���� 0 thecallstatus theCallStatus� m  ]`�� ���  R i n g i n g� E  dk��� o  dg���� 0 thecallstatus theCallStatus� m  gj�� ���  C o n n e c t e d� E  ry��� o  ru���� 0 thecallstatus theCallStatus� m  ux�� ���  C o n n e c t i n g� E  ����� o  ������ 0 thecallstatus theCallStatus� m  ���� ���  D i a l l i n g� r  ����� m  ���� ���  1� o      ���� 0 
callstatus 
callStatus��  � r  ����� m  ���� ���  0� o      ���� 0 
callstatus 
callStatus� R      ������
�� .ascrerr ****      � ****��  ��  � r  ����� m  ���� ���  0� o      ���� 0 
callstatus 
callStatus��  ��  � ���� I  ���������� 0 
get_volume 
get_Volume��  ��  ��  ��  �  �  �   ��� l     ��������  ��  ��  � ��� l      ������  � ^ Xget the current volume state, toggle between call and Mac volume, allow volume selection   � ��� � g e t   t h e   c u r r e n t   v o l u m e   s t a t e ,   t o g g l e   b e t w e e n   c a l l   a n d   M a c   v o l u m e ,   a l l o w   v o l u m e   s e l e c t i o n� ��� i   / 2��� I      �������� 0 
get_volume 
get_Volume��  ��  � k    _�� ��� Z    C������ =    ��� o     ���� 0 
callstatus 
callStatus� m    �� ���  0� k   
 �    I   
 ������ 0 
set_tplink   �� m     �  o f f��  ��    Q    #	
	 l   ���� I    �������� 0 get_xml  ��  ��  ��  ��  
 R      ������
�� .ascrerr ****      � ****��  ��   L   ! #����    Z   $ q�� A  $ + o   $ )���� 0 thecurrvolume theCurrVolume o   ) *���� 0 thecallvolume theCallVolume r   . I I  . G��
�� .sysodlogaskr        TEXT m   . / � B 	 	 	 	 S e l e c t   y o u r   v o l u m e   p r e f e r e n c e ��
�� 
btns J   0 5  m   0 1 �    M u t e !"! m   1 2## �$$  I n   C a l l" %��% m   2 3&& �''  M a c��   ��()
�� 
dflt( m   6 7** �++  I n   C a l l) ��,-
�� 
givu, m   8 9���� - ��.��
�� 
appr. n   < A/0/ 1   = A��
�� 
pnam0  f   < =��   o      ���� 0 b  ��   l  L q1231 r   L q454 I  L o��67
�� .sysodlogaskr        TEXT6 m   L O88 �99 B 	 	 	 	 S e l e c t   y o u r   v o l u m e   p r e f e r e n c e7 ��:;
�� 
btns: J   P [<< =>= m   P S?? �@@  M u t e> ABA m   S VCC �DD  I n   C a l lB E��E m   V YFF �GG  M a c��  ; ��HI
�� 
dfltH m   \ _JJ �KK  M a cI ��LM
�� 
givuL m   ` a���� M ��N��
�� 
apprN n   d iOPO 1   e i��
�� 
pnamP  f   d e��  5 o      ���� 0 b  2 6 0 if currVolume is greater than theMacVolume then   3 �QQ `   i f   c u r r V o l u m e   i s   g r e a t e r   t h a n   t h e M a c V o l u m e   t h e n R��R Z   r �STUVS =  r {WXW n   r wYZY 1   s w��
�� 
bhitZ o   r s���� 0 b  X m   w z[[ �\\  M a cT r   ~ �]^] o   ~ ����� 0 themacvolume theMacVolume^ o      ���� 0 thevar theVarU _`_ =  � �aba n   � �cdc 1   � ���
�� 
bhitd o   � ����� 0 b  b m   � �ee �ff  I n   C a l l` ghg r   � �iji o   � ����� 0 thecallvolume theCallVolumej o      ���� 0 thevar theVarh klk =  � �mnm n   � �opo 1   � ���
�� 
bhitp o   � ����� 0 b  n m   � �qq �rr  M u t el s��s r   � �tut o   � ����� 0 themutevolume theMuteVolumeu o      ���� 0 thevar theVar��  V R   � ����v
�� .ascrerr ****      � ****�  v �~w�}
�~ 
errnw m   � ��|�|���}  ��  � xyx =  � �z{z o   � ��{�{ 0 
callstatus 
callStatus{ m   � �|| �}}  1y ~�z~ k   �? ��� I   � ��y��x�y 0 
set_tplink  � ��w� m   � ��� ���  o n�w  �x  � ��v� Q   �?���� k   �-�� ��� r   � ���� m   � ��� ���  � o      �u�u 0 thevar theVar� ��� r   � ���� m   � ��� ���  � o      �t�t 0 	the2ndvar 	the2ndVar� ��� Z   ����s�r� A  � ���� o   � ��q�q 0 callduration callDuration� m   � ��� ���  3 0� k   ��� ��� r   � ���� o   � ��p�p 0 thecallvolume theCallVolume� o      �o�o 0 thevar theVar� ��� r   ���� J   �
�� ��� m   � ��� ���  C o m m a n d� ��� m   � ��� ��� 
 A u d i o� ��� m   ��� ���  V o l u m e� ��� m  �� ��� $ S e t   c o m m a n d = " T r u e "� ��n� m  �� ��� 
 L e v e l�n  � o      �m�m 0 mycmd myCmd� ��l� I  �k�j�i�k 0 post_cmd  �j  �i  �l  �s  �r  � ��� Z  �����h� F  2��� = "��� o  �g�g 0 
mutestatus 
muteStatus� m  !�� ���  O n� = %.��� o  %*�f�f 0 
thevolmute 
theVolMute� m  *-�� ���  O n� l 5Z���� r  5Z��� I 5X�e��
�e .sysodlogaskr        TEXT� m  58�� ��� > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e� �d��
�d 
btns� J  9D�� ��� m  9<�� ���  U n M u t e   V o l� ��� m  <?�� ���  U n M u t e   A l l� ��c� m  ?B�� ���  D i s c o n n e c t�c  � �b��
�b 
dflt� m  EH�� ���  U n M u t e   A l l� �a��
�a 
givu� m  IJ�`�` � �_��^
�_ 
appr� n  MR��� 1  NR�]
�] 
pnam�  f  MN�^  � o      �\�\ 0 b  � H B option 1 mic and vol are both muted, unmute volume or unmute both   � ��� �   o p t i o n   1   m i c   a n d   v o l   a r e   b o t h   m u t e d ,   u n m u t e   v o l u m e   o r   u n m u t e   b o t h� ��� F  ]���� = ]f��� o  ]b�[�[ 0 
mutestatus 
muteStatus� m  be�� ���  O n� l i���Z�Y� F  i���� = ir��� o  in�X�X 0 
thevolmute 
theVolMute� m  nq�� ���  O f f� @ u|��� o  uz�W�W 0 thecurrvolume theCurrVolume� o  z{�V�V 0 thecallvolume theCallVolume�Z  �Y  � ��� l ��   r  �� I ���U
�U .sysodlogaskr        TEXT m  �� � > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e �T	

�T 
btns	 J  ��  m  �� �  U n M u t e   M i c  m  �� �  M u t e   V o l �S m  �� �  D i s c o n n e c t�S  
 �R
�R 
dflt m  �� �  U n M u t e   M i c �Q
�Q 
givu m  ���P�P  �O�N
�O 
appr n  �� 1  ���M
�M 
pnam  f  ���N   o      �L�L 0 b   b \ option 2 mic is muted volume is not, option to unmute mic or mute vol so that both are mute    �   �   o p t i o n   2   m i c   i s   m u t e d   v o l u m e   i s   n o t ,   o p t i o n   t o   u n m u t e   m i c   o r   m u t e   v o l   s o   t h a t   b o t h   a r e   m u t e� !"! F  ��#$# = ��%&% o  ���K�K 0 
mutestatus 
muteStatus& m  ��'' �((  O n$ l ��)�J�I) F  ��*+* = ��,-, o  ���H�H 0 
thevolmute 
theVolMute- m  ��.. �//  O f f+ A ��010 o  ���G�G 0 thecurrvolume theCurrVolume1 o  ���F�F 0 thecallvolume theCallVolume�J  �I  " 232 l ��4564 r  ��787 I ���E9:
�E .sysodlogaskr        TEXT9 m  ��;; �<< > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e: �D=>
�D 
btns= J  ��?? @A@ m  ��BB �CC  U n M u t e   M i cA DED m  ��FF �GG  M u t e   A l lE H�CH m  ��II �JJ  D i s c o n n e c t�C  > �BKL
�B 
dfltK m  ��MM �NN  U n M u t e   M i cL �AOP
�A 
givuO m  ���@�@ P �?Q�>
�? 
apprQ n  ��RSR 1  ���=
�= 
pnamS  f  ���>  8 o      �<�< 0 b  5 o i option 3 mic is muted volume is lower that thecallvolume but not mute, option to unmute mic or mute all    6 �TT �   o p t i o n   3   m i c   i s   m u t e d   v o l u m e   i s   l o w e r   t h a t   t h e c a l l v o l u m e   b u t   n o t   m u t e ,   o p t i o n   t o   u n m u t e   m i c   o r   m u t e   a l l  3 UVU F  (WXW = 
YZY o  �;�; 0 
mutestatus 
muteStatusZ m  	[[ �\\  O f fX l $]�:�9] F  $^_^ = `a` o  �8�8 0 
thevolmute 
theVolMutea m  bb �cc  O n_ A  ded o  �7�7 0 thecurrvolume theCurrVolumee o  �6�6 0 thecallvolume theCallVolume�:  �9  V fgf l +Phijh r  +Pklk I +N�5mn
�5 .sysodlogaskr        TEXTm m  +.oo �pp > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c en �4qr
�4 
btnsq J  /:ss tut m  /2vv �ww  M u t e   M i cu xyx m  25zz �{{  U n M u t e   A l ly |�3| m  58}} �~~  D i s c o n n e c t�3  r �2�
�2 
dflt m  ;>�� ���  U n M u t e   A l l� �1��
�1 
givu� m  ?@�0�0 � �/��.
�/ 
appr� n  CH��� 1  DH�-
�- 
pnam�  f  CD�.  l o      �,�, 0 b  i j d option 4 if for some reason the mic is not mute but the volume is, option to mute mic or unmute all   j ��� �   o p t i o n   4   i f   f o r   s o m e   r e a s o n   t h e   m i c   i s   n o t   m u t e   b u t   t h e   v o l u m e   i s ,   o p t i o n   t o   m u t e   m i c   o r   u n m u t e   a l lg ��� F  Sl��� = S\��� o  SX�+�+ 0 
mutestatus 
muteStatus� m  X[�� ���  O f f� = _h��� o  _d�*�* 0 
thevolmute 
theVolMute� m  dg�� ���  O f f� ��)� l o����� r  o���� I o��(��
�( .sysodlogaskr        TEXT� m  or�� ��� > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e� �'��
�' 
btns� J  s~�� ��� m  sv�� ���  M u t e   M i c� ��� m  vy�� ���  M u t e   A l l� ��&� m  y|�� ���  D i s c o n n e c t�&  � �%��
�% 
dflt� m  ��� ���  M u t e   M i c� �$��
�$ 
givu� m  ���#�# � �"��!
�" 
appr� n  ����� 1  ��� 
�  
pnam�  f  ���!  � o      �� 0 b  � P J option 5 neither mic and volume are mute, option to mute mic or mute all    � ��� �   o p t i o n   5   n e i t h e r   m i c   a n d   v o l u m e   a r e   m u t e ,   o p t i o n   t o   m u t e   m i c   o r   m u t e   a l l  �)  �h  � ��� Z  �-����� = ����� n  ����� 1  ���
� 
bhit� o  ���� 0 b  � m  ���� ���  U n M u t e   M i c� k  ���� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  M i c r o p h o n e s� ��� m  ���� ���  U n M u t e�  � o      �� 0 mycmd myCmd� ��� I  ������ 0 post_cmd  �  �  � ��� L  ����  �  � ��� = ����� n  ����� 1  ���
� 
bhit� o  ���� 0 b  � m  ���� ���  U n M u t e   V o l� ��� k  ���� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  V o l u m e� ��� m  ���� ���  U n M u t e�  � o      �� 0 mycmd myCmd� ��� I  ������ 0 post_cmd  �  �  � ��� L  ����  �  � ��� = ����� n  ��   1  ���
� 
bhit o  ���
�
 0 b  � m  �� �  U n M u t e   A l l�  k  �/  r  �	
	 J  �  m  �  �  C o m m a n d  m    � 
 A u d i o  m   �  M i c r o p h o n e s �	 m  	 �  U n M u t e�	  
 o      �� 0 mycmd myCmd  r  & J  "  !  m  "" �##  C o m m a n d! $%$ m  && �'' 
 A u d i o% ()( m  ** �++  V o l u m e) ,�, m  -- �..  U n M u t e�   o      �� 0 my2ndcmd my2ndCmd /0/ I  ',���� 0 post_cmd  �  �  0 1�1 L  -/��  �   232 = 2;454 n  27676 1  37� 
�  
bhit7 o  23���� 0 b  5 m  7:88 �99  M u t e   M i c3 :;: k  >[<< =>= r  >R?@? J  >NAA BCB m  >ADD �EE  C o m m a n dC FGF m  ADHH �II 
 A u d i oG JKJ m  DGLL �MM  M i c r o p h o n e sK N��N m  GJOO �PP  M u t e��  @ o      ���� 0 mycmd myCmd> QRQ I  SX�������� 0 post_cmd  ��  ��  R S��S L  Y[����  ��  ; TUT = ^gVWV n  ^cXYX 1  _c��
�� 
bhitY o  ^_���� 0 b  W m  cfZZ �[[  M u t e   V o lU \]\ k  j�^^ _`_ r  j~aba J  jzcc ded m  jmff �gg  C o m m a n de hih m  mpjj �kk 
 A u d i oi lml m  psnn �oo  V o l u m em p��p m  svqq �rr  M u t e��  b o      ���� 0 mycmd myCmd` sts I  ��������� 0 post_cmd  ��  ��  t u��u L  ������  ��  ] vwv = ��xyx n  ��z{z 1  ����
�� 
bhit{ o  ������ 0 b  y m  ��|| �}}  M u t e   A l lw ~~ k  ���� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  M i c r o p h o n e s� ���� m  ���� ���  M u t e��  � o      ���� 0 mycmd myCmd� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  V o l u m e� ���� m  ���� ���  M u t e��  � o      ���� 0 my2ndcmd my2ndCmd� ��� I  ���������� 0 post_cmd  ��  ��  � ���� L  ������  ��   ��� = ����� n  ����� 1  ����
�� 
bhit� o  ������ 0 b  � m  ���� ���  D i s c o n n e c t� ���� k  � �� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ���  C a l l� ���� m  ���� ���  D i s c o n n e c t��  � o      ���� 0 mycmd myCmd� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  V o l u m e� ��� m  ���� ��� $ S e t   c o m m a n d = " T r u e "� ���� m  ���� ��� 
 L e v e l��  � o      ���� 0 my2ndcmd my2ndCmd� ��� r  ���� o  � ���� 0 themacvolume theMacVolume� o      ���� 0 	the2ndvar 	the2ndVar� ��� I  
�������� 0 post_cmd  ��  ��  � ��� I  ������� 0 
set_tplink  � ���� m  �� ���  o f f��  ��  � ��� r  ��� m  �� ���  0� o      ���� 0 
callstatus 
callStatus� ���� L   ����  ��  ��  � R  #-�����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  '*��������  �  � R      ������
�� .ascrerr ****      � ****��  ��  � R  5?�����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  9<��������  �v  �z  ��  � ��� r  DY��� J  DU�� ��� m  DG�� ���  C o m m a n d� ��� m  GJ   � 
 A u d i o�  m  JM �  V o l u m e  m  MP �		 $ S e t   c o m m a n d = " T r u e " 
��
 m  PS � 
 L e v e l��  � o      ���� 0 mycmd myCmd� �� I  Z_�������� 0 post_cmd  ��  ��  ��  �  l     ��������  ��  ��    l      ����   : 4 get the prerequisite user variables for the script     � h   g e t   t h e   p r e r e q u i s i t e   u s e r   v a r i a b l e s   f o r   t h e   s c r i p t    i   3 6 I      ������ 0 get_prereqs get_PreReqs �� o      ���� 
0 action  ��  ��   k    �  Z    ����� =     !  o     ���� 
0 action  ! m    "" �##  g e t P r e f s k   �$$ %&% Q    �'()' l  	 *+,* r   	 -.- I  	 ��/��
�� .sysoexecTEXT���     TEXT/ b   	 010 b   	 232 m   	 
44 �55 0 d e f a u l t s   r e a d   c o m . c i s c o .3 n   
 676 1    ��
�� 
strq7 o   
 ���� 0 	prefsname 	prefsName1 m    88 �99    h o s t n a m e��  . o      ���� 0 thehost theHost+ F @ check to see if a hostname has been previously saved and use it   , �:: �   c h e c k   t o   s e e   i f   a   h o s t n a m e   h a s   b e e n   p r e v i o u s l y   s a v e d   a n d   u s e   i t( R      ������
�� .ascrerr ****      � ****��  ��  ) l   �;<=; k    �>> ?@? I   s��AB
�� .sysodlogaskr        TEXTA b    gCDC b    cEFE b    aGHG b    _IJI b    [KLK b    YMNM b    WOPO b    SQRQ b    QSTS b    MUVU b    KWXW b    GYZY b    E[\[ b    C]^] b    ?_`_ b    =aba b    ;cdc b    7efe b    5ghg b    3iji b    1klk b    /mnm b    -opo b    +qrq b    )sts b    'uvu b    %wxw b    #yzy b    !{|{ m    }} �~~ ^ T h e   S c r i p t   w a s   u n a b l e   t o   r e a d   y o u r   p r e f e r e n c e s .| l 
   ���� o     ��
�� 
ret ��  ��  z m   ! "�� ��� t P l e a s e   h a v e   t h e   f o l l o w i n g   i n f o r m a t i o n   a v a i l a b l e   f o r   i n p u t .x o   # $��
�� 
ret v l 
 % &������ o   % &��
�� 
ret ��  ��  t m   ' (�� ��� > D e s k p r o   h o s t n a m e   o r   I P   a d d r e s s :r l 
 ) *������ o   ) *��
�� 
ret ��  ��  p m   + ,�� ��� " D e s k p r o   U s e r n a m e :n o   - .��
�� 
ret l m   / 0�� ��� 4 D e s k p r o   p a s s w o r d   f o r   u s e r :j l 
 1 2������ o   1 2��
�� 
ret ��  ��  h m   3 4�� ��� > I g n o r e   S e l f   S i g n e d   C e r t   Y e s / N o :f o   5 6��
�� 
ret d m   7 :�� ��� 2 A u t o   A n s w e r   C a l l s   Y e s / N o :b o   ; <��
�� 
ret ` l 
 = >������ o   = >��
�� 
ret ��  ��  ^ m   ? B�� ��� ^ I f   y o u   w a n t   t o   c o n t r o l   a   T P - L i n k   D e v i c e :   Y e s / N o\ o   C D��
�� 
ret Z l 
 E F������ o   E F��
�� 
ret ��  ��  X m   G J�� ��� � I f   y o u   s e l e c t e d   y e s   t o   c o n t r o l   t h e   T P - L i n k   D e v i c e   y o u   w i l l   n e e d :V l 
 K L������ o   K L��
�� 
ret ��  ��  T m   M P�� ���   T P - L i n k   K A S A   I D :R o   Q R��
�� 
ret P m   S V�� ��� * T P - L i n k   D e v i c e   I D ( s ) :N o   W X��
�� 
ret L l 
 Y Z������ o   Y Z��
�� 
ret ��  ��  J m   [ ^�� ��� � Y o u   c a n   s e l e c t   " C a n c e l "   i f   y o u   d o   n o t   h a v e   t h i s   i n f o r m a t i o n   a v a i l a b l e   n o w .H o   _ `��
�� 
ret F l 
 a b������ o   a b��
�� 
ret ��  ��  D m   c f�� ��� � I n s t r u c t i o n s   a r e   l o c a t e d   a t   t h e   t o p   o f   t h e   s c r i p t ,   o p e n   w i t h   a   t e x t   a p p l i c a t i o n   o r   s c r i p t   e d i t o r   t o   r e a d .B �����
�� 
appr� n   j o��� 1   k o��
�� 
pnam�  f   j k��  @ ��� r   t ���� I  t �����
�� .sysodlogaskr        TEXT� l  t w������ m   t w�� ��� X W h a t   i s   y o u r   D e s k p r o   I P   a d d r e s s   o r   H o s t n a m e ?��  ��  � ����
�� 
dtxt� m   z }�� ���  � ����
�� 
appr� n   � ���� 1   � ��~
�~ 
pnam�  f   � ��  � o      �}�} 0 b  � ��� r   � ���� n   � ���� 1   � ��|
�| 
ttxt� o   � ��{�{ 0 b  � o      �z�z 0 thehost theHost� ��y� I  � ��x��w
�x .sysoexecTEXT���     TEXT� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� 2 d e f a u l t s   w r i t e   c o m . c i s c o .� n   � ���� 1   � ��v
�v 
strq� o   � ��u�u 0 	prefsname 	prefsName� m   � ��� ���    h o s t n a m e� m   � ��� ���    '� o   � ��t�t 0 thehost theHost� m   � ��� ���  '�w  �y  < "  no previous username entry    = ��� 8   n o   p r e v i o u s   u s e r n a m e   e n t r y  & ��� Q   ����� l  � ����� r   � ���� I  � ��s��r
�s .sysoexecTEXT���     TEXT� b   � ���� b   � ���� m   � ��� ��� 0 d e f a u l t s   r e a d   c o m . c i s c o .� n   � ���� 1   � ��q
�q 
strq� o   � ��p�p 0 	prefsname 	prefsName� m   � ��� ���    u s e r n a m e�r  � o      �o�o 0 theuser theUser� ; 5 check to see if a username has been previously saved   � ��� j   c h e c k   t o   s e e   i f   a   u s e r n a m e   h a s   b e e n   p r e v i o u s l y   s a v e d� R      �n�m�l
�n .ascrerr ****      � ****�m  �l  � l  ����� k   ��� ��� r   � ���� I  � ��k��
�k .sysodlogaskr        TEXT� l  � ���j�i� m   � ��� ��� < W h a t   i s   y o u r   D e s k p r o   U s e r n a m e ?�j  �i  � �h��
�h 
dtxt� m   � ��� ���  � �g��f
�g 
appr� n   � ���� 1   � ��e
�e 
pnam�  f   � ��f  � o      �d�d 0 b  � ��� r   � ���� n   � ���� 1   � ��c
�c 
ttxt� o   � ��b�b 0 b  � o      �a�a 0 theuser theUser�  �`  I  ��_�^
�_ .sysoexecTEXT���     TEXT b   �	 b   � b   � b   � �	 b   � �

 m   � � � 2 d e f a u l t s   w r i t e   c o m . c i s c o . n   � � 1   � ��]
�] 
strq o   � ��\�\ 0 	prefsname 	prefsName	 m   � � �    u s e r n a m e m   �  �    ' o  �[�[ 0 theuser theUser m   �  '�^  �`  � "  no previous username entry    � � 8   n o   p r e v i o u s   u s e r n a m e   e n t r y  �  Q  � l ( r  (  I $�Z!�Y
�Z .sysoexecTEXT���     TEXT! b   "#" b  $%$ b  &'& m  (( �)) F s e c u r i t y   f i n d - g e n e r i c - p a s s w o r d   - w l  ' n  *+* 1  �X
�X 
strq+ o  �W�W 0 	prefsname 	prefsName% m  ,, �--  .# o  �V�V 0 theuser theUser�Y    o      �U�U 0 mybase64url myBase64Url < 6 check to see if a base64url has been previously saved    �.. l   c h e c k   t o   s e e   i f   a   b a s e 6 4 u r l   h a s   b e e n   p r e v i o u s l y   s a v e d R      �T�S�R
�T .ascrerr ****      � ****�S  �R   l 0�/01/ k  0�22 343 r  07565 m  0377 �88  6 o      �Q�Q 0 trypwd tryPWD4 9:9 W  8{;<; k  Bv== >?> r  B_@A@ I B]�PBC
�P .sysodlogaskr        TEXTB l BED�O�ND m  BEEE �FF < W h a t   i s   y o u r   D e s k p r o   P a s s w o r d ?�O  �N  C �MGH
�M 
dtxtG m  HKII �JJ  H �LKL
�L 
apprK n  NSMNM 1  OS�K
�K 
pnamN  f  NOL �JO�I
�J 
htxtO m  VW�H
�H boovtrue�I  A o      �G�G 0 	passwordq  ? PQP r  `iRSR n  `eTUT 1  ae�F
�F 
ttxtU o  `a�E�E 0 	passwordq  S o      �D�D 0 thepwd thePwdQ V�CV l  jvWXYW r  jvZ[Z I  jr�B\�A�B 0 pwdok pwdOK\ ]�@] o  kn�?�? 0 thepwd thePwd�@  �A  [ o      �>�> 0 trypwd tryPWDX 9 3 Check the password entered for invalid characters    Y �^^ f   C h e c k   t h e   p a s s w o r d   e n t e r e d   f o r   i n v a l i d   c h a r a c t e r s  �C  < = <A_`_ o  <?�=�= 0 trypwd tryPWD` m  ?@�<
�< boovtrue: aba I |��;cd
�; .sysonotfnull��� ��� TEXTc l |e�:�9e m  |ff �gg * C a l c u l a t i n g   b a s e 6 4 u r l�:  �9  d �8h�7
�8 
apprh n  ��iji 1  ���6
�6 
pnamj  f  ���7  b klk r  ��mnm I ���5o�4
�5 .sysoexecTEXT���     TEXTo b  ��pqp b  ��rsr b  ��tut b  ��vwv m  ��xx �yy  p r i n t f  w o  ���3�3 0 theuser theUseru m  ��zz �{{  :s o  ���2�2 0 thepwd thePwdq m  ��|| �}}    |   b a s e 6 4�4  n o      �1�1 0 mybase64url myBase64Urll ~�0~ I ���/�.
�/ .sysoexecTEXT���     TEXT b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� m  ���� ��� B s e c u r i t y   a d d - g e n e r i c - p a s s w o r d   - a  � n  ����� 1  ���-
�- 
strq� o  ���,�, 0 	prefsname 	prefsName� m  ���� ��� 
     - w  � n  ����� 1  ���+
�+ 
strq� o  ���*�* 0 mybase64url myBase64Url� m  ���� ��� V   - j   ' U s e d   b y   A p p l e s c r i p t   D e s k p r o   V o l u m e '   - s� n  ����� 1  ���)
�) 
strq� o  ���(�( 0 	prefsname 	prefsName� m  ���� ���  .� o  ���'�' 0 theuser theUser�.  �0  0 * $ no previous base64url in keychain     1 ��� H   n o   p r e v i o u s   b a s e 6 4 u r l   i n   k e y c h a i n     ��� Q  �^���� l ������ r  ����� I ���&��%
�& .sysoexecTEXT���     TEXT� b  ����� b  ����� m  ���� ��� 0 d e f a u l t s   r e a d   c o m . c i s c o .� n  ����� 1  ���$
�$ 
strq� o  ���#�# 0 	prefsname 	prefsName� m  ���� ��� 0   i g n o r e _ s e l f _ s i g n e d _ c e r t�%  � o      �"�" 0 selfcert  � < 6 check to see if ignore self_signed_cert has been set    � ��� l   c h e c k   t o   s e e   i f   i g n o r e   s e l f _ s i g n e d _ c e r t   h a s   b e e n   s e t  � R      �!� �
�! .ascrerr ****      � ****�   �  � l �^���� k  �^�� ��� r  ���� I ����
� .sysodlogaskr        TEXT� l ������ b  ����� b  ����� b  ����� m  ���� ��� � D o   y o u   w a n t   t h e   s c r i p t   t o   i g n o r e   t h e   d e f a u l t   D e s k p r o   S e l f   S i g n e d   C e r t ?� o  ���
� 
ret � o  ���
� 
ret � m  ���� ��� n   S e t   t h i s   t o   n o   i f   y o u   h a v e   a   v a l i d   c e r t   o n   t h e   d e s k p r o�  �  � ���
� 
btns� J  ��� ��� m  ���� ���  Y e s� ��� m  � �� ���  N o�  � ���
� 
dflt� m  �� ���  Y e s� ���
� 
appr� n  ��� 1  �
� 
pnam�  f  �  � o      �� 0 b  � ��� Z  ^����� = "��� n  ��� 1  �
� 
bhit� o  �� 0 b  � m  !�� ���  Y e s� k  %@�� ��� r  %,��� m  %(�� ���  - k� o      �� 0 selfcert  � ��� I -@���
� .sysoexecTEXT���     TEXT� b  -<��� b  -8��� b  -4��� m  -0�� ��� 2 d e f a u l t s   w r i t e   c o m . c i s c o .� n  03��� 1  13�

�
 
strq� o  01�	�	 0 	prefsname 	prefsName� m  47�� ��� 0   i g n o r e _ s e l f _ s i g n e d _ c e r t� m  8;�� ��� 
   ' - k '�  �  �  � k  C^�� ��� r  CJ��� m  CF�� �    � o      �� 0 selfcert  � � I K^��
� .sysoexecTEXT���     TEXT b  KZ b  KV b  KR m  KN		 �

 2 d e f a u l t s   w r i t e   c o m . c i s c o . n  NQ 1  OQ�
� 
strq o  NO�� 0 	prefsname 	prefsName m  RU � 0   i g n o r e _ s e l f _ s i g n e d _ c e r t m  VY �    ' '�  �  �  � i c no previous autoanswer entry to ignore the self signed cert we inject a -k into the curl commands    � � �   n o   p r e v i o u s   a u t o a n s w e r   e n t r y   t o   i g n o r e   t h e   s e l f   s i g n e d   c e r t   w e   i n j e c t   a   - k   i n t o   t h e   c u r l   c o m m a n d s  �  Q  _� l bu r  bu I bq��
� .sysoexecTEXT���     TEXT b  bm b  bi  m  be!! �"" 0 d e f a u l t s   r e a d   c o m . c i s c o .  n  eh#$# 1  fh� 
�  
strq$ o  ef���� 0 	prefsname 	prefsName m  il%% �&&    A u t o A n s w e r�   o      ���� 0 
autoanswer 
AutoAnswer 0 * check to see if Auto Answer has been set     �'' T   c h e c k   t o   s e e   i f   A u t o   A n s w e r   h a s   b e e n   s e t   R      ������
�� .ascrerr ****      � ****��  ��   l }�()*( k  }�++ ,-, r  }�./. I }���01
�� .sysodlogaskr        TEXT0 l }�2����2 m  }�33 �44 v D o   y o u   w a n t   t h e   s c r i p t   t o   b e   a b l e   t o   a n s w e r   i n c o m i n g   c a l l s ?��  ��  1 ��56
�� 
btns5 J  ��77 898 m  ��:: �;;  Y e s9 <��< m  ��== �>>  N o��  6 ��?@
�� 
dflt? m  ��AA �BB  Y e s@ ��C��
�� 
apprC n  ��DED 1  ����
�� 
pnamE  f  ����  / o      ���� 0 b  - FGF r  ��HIH 1  ����
�� 
rsltI o      ���� 0 
autoanswer 
AutoAnswerG J��J I ����K��
�� .sysoexecTEXT���     TEXTK b  ��LML b  ��NON b  ��PQP m  ��RR �SS 2 d e f a u l t s   w r i t e   c o m . c i s c o .Q n  ��TUT 1  ����
�� 
strqU o  ������ 0 	prefsname 	prefsNameO m  ��VV �WW    A u t o A n s w e rM m  ��XX �YY    ' Y e s '��  ��  ) #  no previous autoanswer entry   * �ZZ :   n o   p r e v i o u s   a u t o a n s w e r   e n t r y [\[ l ����������  ��  ��  \ ]^] Q  �_`a_ l ��bcdb r  ��efe I ����g��
�� .sysoexecTEXT���     TEXTg b  ��hih b  ��jkj m  ��ll �mm 0 d e f a u l t s   r e a d   c o m . c i s c o .k n  ��non 1  ����
�� 
strqo o  ������ 0 	prefsname 	prefsNamei m  ��pp �qq    v o l u m e _ c a l l��  f o      ���� 0 thecallvolume theCallVolumec > 8 check to see if a call volume has been previously saved   d �rr p   c h e c k   t o   s e e   i f   a   c a l l   v o l u m e   h a s   b e e n   p r e v i o u s l y   s a v e d` R      ������
�� .ascrerr ****      � ****��  ��  a l �stus k  �vv wxw r  ��yzy I ����{|
�� .sysodlogaskr        TEXT{ l ��}����} m  ��~~ � \ W h a t   i s   y o u r   p r e f e r r e d   v o l u m e   w h i l e   i n   a   c a l l ?��  ��  | ����
�� 
dtxt� m  ���� ���  5 5� �����
�� 
appr� n  ����� 1  ����
�� 
pnam�  f  ����  z o      ���� 0 b  x ��� r  ����� n  ����� 1  ����
�� 
ttxt� o  ������ 0 b  � o      ���� 0 thecallvolume theCallVolume� ���� I  �����
�� .sysoexecTEXT���     TEXT� b   ��� b   ��� b   ��� b   ��� b   ��� m   �� ��� 2 d e f a u l t s   w r i t e   c o m . c i s c o .� n  ��� 1  ��
�� 
strq� o  ���� 0 	prefsname 	prefsName� m  
�� ���    v o l u m e _ c a l l� m  �� ���    '� o  ���� 0 thecallvolume theCallVolume� m  �� ���  '��  ��  t "  no previous username entry    u ��� 8   n o   p r e v i o u s   u s e r n a m e   e n t r y  ^ ��� Q  y���� l 2���� r  2��� I .�����
�� .sysoexecTEXT���     TEXT� b  *��� b  &��� m  "�� ��� 0 d e f a u l t s   r e a d   c o m . c i s c o .� n  "%��� 1  #%��
�� 
strq� o  "#���� 0 	prefsname 	prefsName� m  &)�� ���    v o l u m e _ M a c��  � o      ���� 0 themacvolume theMacVolume� = 7 check to see if a Mac Volume has been previously saved   � ��� n   c h e c k   t o   s e e   i f   a   M a c   V o l u m e   h a s   b e e n   p r e v i o u s l y   s a v e d� R      ������
�� .ascrerr ****      � ****��  ��  � l :y���� k  :y�� ��� r  :S��� I :Q����
�� .sysodlogaskr        TEXT� l :=������ m  :=�� ��� j W h a t   i s   y o u r   p r e f e r r e d   v o l u m e   f o r   M a c   S p e a k e r   o u t p u t ?��  ��  � ����
�� 
dtxt� m  @C�� ���  2 0� �����
�� 
appr� n  FK��� 1  GK��
�� 
pnam�  f  FG��  � o      ���� 0 b  � ��� r  T]��� n  TY��� 1  UY��
�� 
ttxt� o  TU���� 0 b  � o      ���� 0 themacvolume theMacVolume� ���� I ^y�����
�� .sysoexecTEXT���     TEXT� b  ^u��� b  ^q��� b  ^m��� b  ^i��� b  ^e��� m  ^a�� ��� 2 d e f a u l t s   w r i t e   c o m . c i s c o .� n  ad��� 1  bd��
�� 
strq� o  ab���� 0 	prefsname 	prefsName� m  eh�� ���    v o l u m e _ M a c� m  il�� ���    '� o  mp���� 0 themacvolume theMacVolume� m  qt�� ���  '��  ��  � "  no previous username entry    � ��� 8   n o   p r e v i o u s   u s e r n a m e   e n t r y  � ��� Q  z����� Z  }3������ = }���� l }������� I }������
�� .sysoexecTEXT���     TEXT� b  }���� b  }���� m  }��� ��� 0 d e f a u l t s   r e a d   c o m . c i s c o .� n  ����� 1  ����
�� 
strq� o  ������ 0 	prefsname 	prefsName� m  ���� �	 	     t p l i n k _ c o n t r o l��  ��  ��  � m  ��		 �		  1� k  �)		 			 r  ��			 m  ��		 �				  1	 o      ���� 
0 tplink  	 	
��	
 Q  �)				 r  ��			 I ����	��
�� .sysoexecTEXT���     TEXT	 b  ��			 b  ��			 m  ��		 �		 0 d e f a u l t s   r e a d   c o m . c i s c o .	 n  ��			 1  ����
�� 
strq	 o  ������ 0 	prefsname 	prefsName	 m  ��		 �		    T P L i n k _ d e v i c e s��  	 o      ���� "0 mytplinkdevices myTPLinkDevices	 R      ������
�� .ascrerr ****      � ****��  ��  	 k  �)		 			 r  ��			 m  ��	 	  �	!	!  1	 o      ���� "0 newtplinkdevice newTPLinkDevice	 	"	#	" r  ��	$	%	$ J  ������  	% o      ���� "0 mytplinkdevices myTPLinkDevices	# 	&	'	& W  �	(	)	( k  �	*	* 	+	,	+ r  ��	-	.	- I ����	/	0
�� .sysodlogaskr        TEXT	/ m  ��	1	1 �	2	2 8 E n t e r   y o u r   T P - L i n k   d e v i c e   I d	0 ��	3	4
�� 
dtxt	3 m  ��	5	5 �	6	6  	4 ��	7��
�� 
appr	7 n  ��	8	9	8 1  ����
�� 
pnam	9  f  ����  	. o      ���� "0 newtplinkdevice newTPLinkDevice	, 	:	;	: r  ��	<	=	< n  ��	>	?	> 1  ����
�� 
ttxt	? o  ������ "0 newtplinkdevice newTPLinkDevice	= o      ���� "0 newtplinkdevice newTPLinkDevice	; 	@��	@ Z  �	A	B����	A > ��	C	D	C o  ������ "0 newtplinkdevice newTPLinkDevice	D m  ��	E	E �	F	F  	B r  �	G	H	G b  ��	I	J	I o  ������ "0 newtplinkdevice newTPLinkDevice	J m  ��	K	K �	L	L  \ r	H l     	M����	M n      	N	O	N  ;  	O o  ����� "0 mytplinkdevices myTPLinkDevices��  ��  ��  ��  ��  	) = ��	P	Q	P o  ������ "0 newtplinkdevice newTPLinkDevice	Q m  ��	R	R �	S	S  	' 	T��	T I )��	U��
�� .sysoexecTEXT���     TEXT	U b  %	V	W	V b  !	X	Y	X b  	Z	[	Z b  	\	]	\ b  	^	_	^ m  	`	` �	a	a 2 d e f a u l t s   w r i t e   c o m . c i s c o .	_ n  	b	c	b 1  ��
�� 
strq	c o  ���� 0 	prefsname 	prefsName	] m  	d	d �	e	e    T P L i n k _ d e v i c e s	[ m  	f	f �	g	g    '	Y o   ���� "0 mytplinkdevices myTPLinkDevices	W m  !$	h	h �	i	i  '��  ��  ��  ��  � r  ,3	j	k	j m  ,/	l	l �	m	m  0	k o      ���� 
0 tplink  � R      ������
�� .ascrerr ****      � ****��  ��  � k  ;�	n	n 	o	p	o r  ;_	q	r	q I ;]��	s	t
�� .sysodlogaskr        TEXT	s l ;>	u����	u m  ;>	v	v �	w	w t D o   y o u   w a n t   t h e   s c r i p t   t o   c o n t r o l   a n   I n - C a l l   S t a t u s   L i g h t ?��  ��  	t ��	x	y
�� 
btns	x J  AI	z	z 	{	|	{ m  AD	}	} �	~	~  Y e s	| 	��	 m  DG	�	� �	�	�  N o��  	y �	�	�
� 
dflt	� m  LO	�	� �	�	�  Y e s	� �~	��}
�~ 
appr	� n  RW	�	�	� 1  SW�|
�| 
pnam	�  f  RS�}  	r o      �{�{ 0 c  	p 	�	�	� Z  `�	�	��z	�	� = `i	�	�	� n  `e	�	�	� 1  ae�y
�y 
bhit	� o  `a�x�x 0 c  	� m  eh	�	� �	�	�  Y e s	� k  l�	�	� 	�	�	� I l�w	��v
�w .sysoexecTEXT���     TEXT	� b  l{	�	�	� b  lw	�	�	� b  ls	�	�	� m  lo	�	� �	�	� 2 d e f a u l t s   w r i t e   c o m . c i s c o .	� n  or	�	�	� 1  pr�u
�u 
strq	� o  op�t�t 0 	prefsname 	prefsName	� m  sv	�	� �	�	�    t p l i n k _ c o n t r o l	� m  wz	�	� �	�	�    ' 1 '�v  	� 	��s	� r  ��	�	�	� m  ��	�	� �	�	�  1	� o      �r�r 
0 tplink  �s  �z  	� k  ��	�	� 	�	�	� I ���q	��p
�q .sysoexecTEXT���     TEXT	� b  ��	�	�	� b  ��	�	�	� b  ��	�	�	� m  ��	�	� �	�	� 2 d e f a u l t s   w r i t e   c o m . c i s c o .	� n  ��	�	�	� 1  ���o
�o 
strq	� o  ���n�n 0 	prefsname 	prefsName	� m  ��	�	� �	�	�    t p l i n k _ c o n t r o l	� m  ��	�	� �	�	�    ' 0 '�p  	� 	��m	� r  ��	�	�	� m  ��	�	� �	�	�  0	� o      �l�l 
0 tplink  �m  	� 	��k	� I  ���j	��i�j 0 get_prereqs get_PreReqs	� 	��h	� m  ��	�	� �	�	�  g e t P r e f s�h  �i  �k  � 	��g	� l ���f�e�d�f  �e  �d  �g  ��  ��   	��c	� L  ���b�b  �c   	�	�	� l     �a�`�_�a  �`  �_  	� 	�	�	� i   7 :	�	�	� I      �^�]�\�^ 0 post_cmd  �]  �\  	� k    	�	� 	�	�	� r     	�	�	� J     �[�[  	� o      �Z�Z 0 
mycmdstart 
myCmdStart	� 	�	�	� r    		�	�	� J    �Y�Y  	� o      �X�X 0 mycmdend myCmdEnd	� 	�	�	� r   
 	�	�	� n   
 	�	�	� 2   �W
�W 
cobj	� o   
 �V�V 0 mycmd myCmd	� o      �U�U 0 newcmd newCmd	� 	�	�	� X    N	��T	�	� Z     I	�	��S�R	� >    #	�	�	� o     !�Q�Q 0 
newelement 
newElement	� m   ! "	�	� �	�	�  	� k   & E	�	� 	�	�	� r   & .	�	�	� b   & +	�	�	� b   & )	�	�	� m   & '	�	� �	�	�  <	� o   ' (�P�P 0 
newelement 
newElement	� m   ) *	�	� �	�	�  >	� l     	��O�N	� n      	�	�	�  ;   , -	� o   + ,�M�M 0 
mycmdstart 
myCmdStart�O  �N  	� 	�	�	� Z   / <	�	��L�K	� E   / 2	�	�	� o   / 0�J�J 0 
newelement 
newElement	� m   0 1	�	� �	�	� $ S e t   c o m m a n d = " T r u e "	� r   5 8
 

  m   5 6

 �

  S e t
 o      �I�I 0 
newelement 
newElement�L  �K  	� 
�H
 r   = E


 b   = B


 b   = @
	


	 m   = >

 �

  < /

 o   > ?�G�G 0 
newelement 
newElement
 m   @ A

 �

  >
 l     
�F�E
 n      


  :   C D
 o   B C�D�D 0 mycmdend myCmdEnd�F  �E  �H  �S  �R  �T 0 
newelement 
newElement	� o    �C�C 0 newcmd newCmd	� 


 r   O p


 b   O l


 b   O h


 b   O f


 b   O b


 b   O `


 b   O \
 
!
  b   O X
"
#
" b   O T
$
%
$ b   O R
&
'
& o   O P�B�B 0 selfcert  
' m   P Q
(
( �
)
) H   - - l o c a t i o n   - - r e q u e s t   P O S T   " h t t p s : / /
% o   R S�A�A 0 thehost theHost
# m   T W
*
* �
+
+ P / p u t x m l "   - - h e a d e r   ' A u t h o r i z a t i o n :   B a s i c  
! o   X [�@�@ 0 mybase64url myBase64Url
 m   \ _
,
, �
-
- d '   - - h e a d e r   ' C o n t e n t - T y p e :   t e x t / p l a i n '   - - d a t a - r a w   '
 o   ` a�?�? 0 
mycmdstart 
myCmdStart
 o   b e�>�> 0 thevar theVar
 o   f g�=�= 0 mycmdend myCmdEnd
 m   h k
.
. �
/
/  '    
 o      �<�< 0 postcmd postCmd
 
0
1
0 l  q q�;�:�9�;  �:  �9  
1 
2
3
2 Z   q
4
5�8�7
4 >  q w
6
7
6 o   q t�6�6 0 my2ndcmd my2ndCmd
7 J   t v�5�5  
5 k   z
8
8 
9
:
9 r   z ~
;
<
; J   z |�4�4  
< o      �3�3 0 my2ndcmdstart my2ndCmdStart
: 
=
>
= r    �
?
@
? J    ��2�2  
@ o      �1�1 0 my2ndcmdend my2ndCmdEnd
> 
A
B
A r   � �
C
D
C n   � �
E
F
E 2  � ��0
�0 
cobj
F o   � ��/�/ 0 my2ndcmd my2ndCmd
D o      �.�. 0 	new2ndcmd 	new2ndCmd
B 
G
H
G X   � �
I�-
J
I Z   � �
K
L�,�+
K >  � �
M
N
M o   � ��*�* 0 new2ndelement new2ndElement
N m   � �
O
O �
P
P  
L k   � �
Q
Q 
R
S
R r   � �
T
U
T b   � �
V
W
V b   � �
X
Y
X m   � �
Z
Z �
[
[  <
Y o   � ��)�) 0 new2ndelement new2ndElement
W m   � �
\
\ �
]
]  >
U l     
^�(�'
^ n      
_
`
_  ;   � �
` o   � ��&�& 0 my2ndcmdstart my2ndCmdStart�(  �'  
S 
a
b
a Z   � �
c
d�%�$
c E   � �
e
f
e o   � ��#�# 0 new2ndelement new2ndElement
f m   � �
g
g �
h
h $ S e t   c o m m a n d = " T r u e "
d r   � �
i
j
i m   � �
k
k �
l
l  S e t
j o      �"�" 0 new2ndelement new2ndElement�%  �$  
b 
m�!
m r   � �
n
o
n b   � �
p
q
p b   � �
r
s
r m   � �
t
t �
u
u  < /
s o   � �� �  0 new2ndelement new2ndElement
q m   � �
v
v �
w
w  >
o l     
x��
x n      
y
z
y  :   � �
z o   � ��� 0 my2ndcmdend my2ndCmdEnd�  �  �!  �,  �+  �- 0 new2ndelement new2ndElement
J o   � ��� 0 	new2ndcmd 	new2ndCmd
H 
{�
{ r   �
|
}
| b   � 
~

~ b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� o   � ��� 0 postcmd postCmd
� m   � �
�
� �
�
�    - :  
� o   � ��� 0 selfcert  
� m   � �
�
� �
�
� J     - - l o c a t i o n   - - r e q u e s t   P O S T   " h t t p s : / /
� o   � ��� 0 thehost theHost
� m   � �
�
� �
�
� P / p u t x m l "   - - h e a d e r   ' A u t h o r i z a t i o n :   B a s i c  
� o   � ��� 0 mybase64url myBase64Url
� m   � �
�
� �
�
� d '   - - h e a d e r   ' C o n t e n t - T y p e :   t e x t / p l a i n '   - - d a t a - r a w   '
� o   � ��� 0 my2ndcmdstart my2ndCmdStart
� o   � ��� 0 	the2ndvar 	the2ndVar
� o   � ��� 0 my2ndcmdend my2ndCmdEnd
 m   � �
�
� �
�
�  '
} o      �� 0 postcmd postCmd�  �8  �7  
3 
��
� l  	
�
�
�
� I 	�
��
� .sysoexecTEXT���     TEXT
� b  	
�
�
� b  	
�
�
� m  	
�
� �
�
� 
 c u r l  
� o  �� 0 postcmd postCmd
� m  
�
� �
�
�    & >   / d e v / n u l l  �  
� &   Send the command to the device    
� �
�
� @   S e n d   t h e   c o m m a n d   t o   t h e   d e v i c e  �  	� 
�
�
� l     ����  �  �  
� 
�
�
� i   ; >
�
�
� I      ��
�	� 0 get_xml  �
  �	  
� k     }
�
� 
�
�
� r     
�
�
� m     
�
� �
�
� �   - e   " < S t a t u s > "   - e   " D u r a t i o n "   - e   " A n s w e r "   - e   " M u t e "   - e   " V o l u m e I n t e r n a l "  
� o      �� 0 grep_for  
� 
�
�
� r    
�
�
� n    
�
�
� 2   �
� 
cpar
� l   
���
� I   �
��
� .sysoexecTEXT���     TEXT
� b    
�
�
� b    
�
�
� b    
�
�
� b    	
�
�
� b    
�
�
� m    
�
� �
�
� T c u r l   - k   - - l o c a t i o n   - - r e q u e s t   G E T   " h t t p s : / /
� o    �� 0 thehost theHost
� m    
�
� �
�
� r / g e t x m l ? l o c a t i o n = / S t a t u s "   - - h e a d e r   ' A u t h o r i z a t i o n :   B a s i c  
� o   	 
�� 0 mybase64url myBase64Url
� m    
�
� �
�
�  '       |   g r e p  
� o    � �  0 grep_for  �  �  �  
� o      ���� $0 thestatusresults theStatusResults
� 
�
�
� Q    {
�
���
� k    r
�
� 
�
�
� r    (
�
�
� n    "
�
�
� 4    "��
�
�� 
cwor
� m     !���� 
� n    
�
�
� 4    ��
�
�� 
cobj
� m    ���� 	
� o    ���� $0 thestatusresults theStatusResults
� o      ���� 0 
mutestatus 
muteStatus
� 
�
�
� r   ) 6
�
�
� n   ) 0
�
�
� 4   - 0��
�
�� 
cwor
� m   . /���� 
� n   ) -
�
�
� 4   * -��
�
�� 
cobj
� m   + ,���� 

� o   ) *���� $0 thestatusresults theStatusResults
� o      ���� 0 thecurrvolume theCurrVolume
� 
�
�
� r   7 D
�
�
� n   7 >
�
�
� 4   ; >��
�
�� 
cwor
� m   < =���� 
� n   7 ;
�
�
� 4   8 ;��
�
�� 
cobj
� m   9 :���� 
� o   7 8���� $0 thestatusresults theStatusResults
� o      ���� 0 
thevolmute 
theVolMute
� 
�
�
� r   E R
�
�
� n   E L
�
�
� 4   I L��
�
�� 
cwor
� m   J K���� 
� n   E I
�
�
� 4   F I��
�
�� 
cobj
� m   G H���� 
� o   E F���� $0 thestatusresults theStatusResults
� o      ���� 0 answeredstate answeredState
� 
�
�
� r   S b   n   S \ 4   Y \��
�� 
cwor m   Z [����  n   S Y 4   T Y��
�� 
cobj m   U X����  o   S T���� $0 thestatusresults theStatusResults o      ���� 0 callduration callDuration
� �� r   c r	
	 n   c l 4   i l��
�� 
cwor m   j k����  n   c i 4   d i��
�� 
cobj m   e h����  o   c d���� $0 thestatusresults theStatusResults
 o      ���� 0 
callstatus 
callStatus��  
� R      ������
�� .ascrerr ****      � ****��  ��  ��  
� �� l  | |����  <6	display dialog "Deskpro Call States" & return & "Call Status: " & callStatus & return & "Call Duration: " & callDuration & return & "Answered State: " & answeredState & return & return & "Deskpro Volume States" & return & "Current Volume is: " & theCurrVolume & return & "The Mic Mute State is: " & muteStatus    �l 	 d i s p l a y   d i a l o g   " D e s k p r o   C a l l   S t a t e s "   &   r e t u r n   &   " C a l l   S t a t u s :   "   &   c a l l S t a t u s   &   r e t u r n   &   " C a l l   D u r a t i o n :   "   &   c a l l D u r a t i o n   &   r e t u r n   &   " A n s w e r e d   S t a t e :   "   &   a n s w e r e d S t a t e   &   r e t u r n   &   r e t u r n   &   " D e s k p r o   V o l u m e   S t a t e s "   &   r e t u r n   &   " C u r r e n t   V o l u m e   i s :   "   &   t h e C u r r V o l u m e   &   r e t u r n   &   " T h e   M i c   M u t e   S t a t e   i s :   "   &   m u t e S t a t u s��  
�  l     ��������  ��  ��    l      ����   B < CONTROL TP-LINK SMART OUTLET as "In Call" status indicator     � x   C O N T R O L   T P - L I N K   S M A R T   O U T L E T   a s   " I n   C a l l "   s t a t u s   i n d i c a t o r    i   ? B I      �� ���� 0 
set_tplink    !��! o      ���� 	0 state  ��  ��   Z     <"#����" =    $%$ o     ���� 
0 tplink  % m    && �''  1# Q    8()��( X   	 /*��+* k    *,, -.- l   /01/ r    232 o    ���� 0 
mydeviceid 
myDeviceid3 o      ���� 0 
mydeviceid 
myDeviceid0   of myTPLinkDevices   1 �44 &   o f   m y T P L i n k D e v i c e s. 5��5 I   *��6��
�� .sysoexecTEXT���     TEXT6 b    &787 b    $9:9 b    ";<; m     == �>> 6 / u s r / l o c a l / b i n / k a s a   - - h o s t  < o     !���� 0 
mydeviceid 
myDeviceid: m   " #?? �@@   8 o   $ %���� 	0 state  ��  ��  �� 0 
mydeviceid 
myDeviceid+ n    ABA 2   ��
�� 
cworB o    ���� "0 mytplinkdevices myTPLinkDevices) R      ������
�� .ascrerr ****      � ****��  ��  ��  ��  ��   CDC l     ��������  ��  ��  D EFE l     ��GH��  G ^ X Verify that a thePwd does not contain any characters that will break the base64 command   H �II �   V e r i f y   t h a t   a   t h e P w d   d o e s   n o t   c o n t a i n   a n y   c h a r a c t e r s   t h a t   w i l l   b r e a k   t h e   b a s e 6 4   c o m m a n dF JKJ i   C FLML I      ��N���� 0 pwdok pwdOKN O��O o      ���� 0 thepwd thePwd��  ��  M k     *PP QRQ r     STS n     UVU 2   ��
�� 
cha V o     ���� 0 thepwd thePwdT o      ���� 0 pwdchars PWDcharsR WXW X    'Y��ZY Z    "[\����[ E   ]^] o    ���� 0 badpwdchars BadPWDchars^ o    ���� 0 ch  \ L    __ m    ��
�� boovfals��  ��  �� 0 ch  Z o   	 
���� 0 pwdchars PWDcharsX `��` L   ( *aa m   ( )��
�� boovtrue��  K bcb l     ��������  ��  ��  c ded i   G Jfgf I      ��h���� ,0 removemarkupfromtext removeMarkupFromTexth i��i o      ���� 0 thetext theText��  ��  g k     ]jj klk r     mnm m     ��
�� boovfalsn o      ���� 0 tagdetected tagDetectedl opo r    qrq m    ss �tt  r o      ���� 0 thecleantext theCleanTextp uvu Y    Vw��xy��w k    Qzz {|{ r    }~} n    � 4    ���
�� 
cha � o    ���� 0 a  � o    ���� 0 thetext theText~ o      ���� *0 thecurrentcharacter theCurrentCharacter| ���� Z     Q������ =    #��� o     !���� *0 thecurrentcharacter theCurrentCharacter� m   ! "�� ���  <� r   & )��� m   & '��
�� boovtrue� o      ���� 0 tagdetected tagDetected� ��� =  , /��� o   , -���� *0 thecurrentcharacter theCurrentCharacter� m   - .�� ���  >� ��� r   2 5��� m   2 3��
�� boovfals� o      ���� 0 tagdetected tagDetected� ��� =  8 ;��� o   8 9���� 0 tagdetected tagDetected� m   9 :��
�� boovfals� ���� r   > M��� c   > G��� b   > E��� o   > C���� 0 thecleantext theCleanText� o   C D���� *0 thecurrentcharacter theCurrentCharacter� m   E F��
�� 
TEXT� o      ���� 0 thecleantext theCleanText��  ��  ��  �� 0 a  x m    ���� y n    ��� 1    ��
�� 
leng� o    ���� 0 thetext theText��  v ���� L   W ]�� o   W \���� 0 thecleantext theCleanText��  e ��� l     ��������  ��  ��  � ��� l      ����  � L F USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND    � ��� �   U S E D   F O R   T E S T I N G   T O T A L   T I M E   T O   E X E C U T E   T H E   S C R I P T   T O   T H E   M I L L I S E C O N D  � ��� l     �~���~  � . (set mgStop to do shell script mgRightNow   � ��� P s e t   m g S t o p   t o   d o   s h e l l   s c r i p t   m g R i g h t N o w� ��� l     �}���}  � ' !set mgRunTime to mgStop - mgStart   � ��� B s e t   m g R u n T i m e   t o   m g S t o p   -   m g S t a r t� ��� l     �|���|  � � zdisplay dialog "This took " & mgRunTime & " seconds." & return & "that's " & (round (mgRunTime * 1000)) & " milliseconds."   � ��� � d i s p l a y   d i a l o g   " T h i s   t o o k   "   &   m g R u n T i m e   &   "   s e c o n d s . "   &   r e t u r n   &   " t h a t ' s   "   &   ( r o u n d   ( m g R u n T i m e   *   1 0 0 0 ) )   &   "   m i l l i s e c o n d s . "� ��� l     �{�z�y�{  �z  �y  � ��x� l     �w�v�u�w  �v  �u  �x       �t�� � � � � � � � ����������t  � �s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c
�s 
pimr�r 0 
mutestatus 
muteStatus�q 0 thecurrvolume theCurrVolume�p 0 answeredstate answeredState�o 0 callduration callDuration�n 0 	thevolume 	theVolume�m 0 
callstatus 
callStatus�l 0 
thevolmute 
theVolMute�k 0 thecleantext theCleanText�j 0 
get_volume 
get_Volume�i 0 get_prereqs get_PreReqs�h 0 post_cmd  �g 0 get_xml  �f 0 
set_tplink  �e 0 pwdok pwdOK�d ,0 removemarkupfromtext removeMarkupFromText
�c .aevtoappnull  �   � ****� �b��b �  ��� �a �`
�a 
vers�`  � �_��^
�_ 
cobj� ��   �]
�] 
osax�^  � �\��[�Z���Y�\ 0 
get_volume 
get_Volume�[  �Z  � �X�X 0 b  � ���W�V�U�T�S�R#&�Q*�P�O�N�M�L�K8?CFJ�J[�I�Heq�G�F�E|����D�������C�B���A�������'.;BFIM[bovz}��������������@�����"&*-�?8DHLOZfjnq|�������������������� �W 0 
set_tplink  �V 0 get_xml  �U  �T  �S 0 thecallvolume theCallVolume
�R 
btns
�Q 
dflt
�P 
givu�O 
�N 
appr
�M 
pnam�L 
�K .sysodlogaskr        TEXT
�J 
bhit�I 0 themacvolume theMacVolume�H 0 thevar theVar�G 0 themutevolume theMuteVolume
�F 
errn�E���D 0 	the2ndvar 	the2ndVar�C 0 mycmd myCmd�B 0 post_cmd  
�A 
bool�@ �? 0 my2ndcmd my2ndCmd�Y`b  �  �*�k+ O 
*j+ W 	X  hOb  �  �����mv����a )a ,a  E�Y 'a �a a a mv�a ��a )a ,a  E�O�a ,a   _ E` Y 6�a ,a   
�E` Y "�a ,a   _ E` Y )a  a !lhY�b  a " y*a #k+ O[a $E` Oa %E` &Ob  a ' &�E` Oa (a )a *a +a ,�vE` -O*j+ .Y hOb  a / 	 b  a 0 a 1& *a 2�a 3a 4a 5mv�a 6��a )a ,a  E�Y=b  a 7 	 b  a 8 	 b  �a 1&a 1& *a 9�a :a ;a <mv�a =��a )a ,a  E�Y �b  a > 	 b  a ? 	 b  �a 1&a 1& *a @�a Aa Ba Cmv�a D��a )a ,a  E�Y �b  a E 	 b  a F 	 b  �a 1&a 1& *a G�a Ha Ia Jmv�a K��a )a ,a  E�Y Gb  a L 	 b  a M a 1& *a N�a Oa Pa Qmv�a R��a )a ,a  E�Y hO�a ,a S  "a Ta Ua Va Wa XvE` -O*j+ .OhYj�a ,a Y  "a Za [a \a ]a XvE` -O*j+ .OhY>�a ,a ^  7a _a `a aa ba XvE` -Oa ca da ea fa XvE` gO*j+ .OhY ��a ,a h  "a ia ja ka la XvE` -O*j+ .OhY Ѡa ,a m  "a na oa pa qa XvE` -O*j+ .OhY ��a ,a r  7a sa ta ua va XvE` -Oa wa xa ya za XvE` gO*j+ .OhY d�a ,a {  Na |a }a ~mvE` -Oa a �a �a �a ��vE` gO_ E` &O*j+ .O*a �k+ Oa �Ec  OhY )a  a !lhW X  )a  a !lhY hOa �a �a �a �a ��vE` -O*j+ .� �>�=�<���;�> 0 get_prereqs get_PreReqs�= �:��: �  �9�9 
0 action  �<  � �8�7�6�5�4�8 
0 action  �7 0 b  �6 0 	passwordq  �5 "0 newtplinkdevice newTPLinkDevice�4 0 c  � �"4�3�28�1�0�/�.}�-�������������,�+�*��)��(�'�������&��(,�%7�$EI�#�"�!� f�xz|���������������������	!%�3:=A�RVXlp�~����������������		�		�	 	R	1	5	E	K	`	d	f	h	l	v	}	�	�	�	�	�	�	�	�	�	�	�	���3 0 	prefsname 	prefsName
�2 
strq
�1 .sysoexecTEXT���     TEXT�0 0 thehost theHost�/  �.  
�- 
ret 
�, 
appr
�+ 
pnam
�* .sysodlogaskr        TEXT
�) 
dtxt�( 
�' 
ttxt�& 0 theuser theUser�% 0 mybase64url myBase64Url�$ 0 trypwd tryPWD
�# 
htxt�" �! 0 thepwd thePwd�  0 pwdok pwdOK
� .sysonotfnull��� ��� TEXT� 0 selfcert  
� 
btns
� 
dflt
� 
bhit� 0 
autoanswer 
AutoAnswer
� 
rslt� 0 thecallvolume theCallVolume� 0 themacvolume theMacVolume� 
0 tplink  � "0 mytplinkdevices myTPLinkDevices� 0 get_prereqs get_PreReqs�;��� � ���,%�%j E�W �X  ��%�%�%�%�%�%�%�%�%�%�%�%a %�%�%a %�%�%a %�%a %�%a %�%�%a %�%�%a %a )a ,l Oa a a a )a ,a  E�O�a ,E�Oa ��,%a  %a !%�%a "%j O a #��,%a $%j E` %W FX  a &a a 'a )a ,a  E�O�a ,E` %Oa (��,%a )%a *%_ %%a +%j O a ,��,%a -%_ %%j E` .W �X  a /E` 0O Bh_ 0e a 1a a 2a )a ,a 3ea 4 E�O�a ,E` 5O*_ 5k+ 6E` 0[OY��Oa 7a )a ,l 8Oa 9_ %%a :%_ 5%a ;%j E` .Oa <��,%a =%_ .�,%a >%��,%a ?%_ %%j O a @��,%a A%j E` BW yX  a C�%�%a D%a Ea Fa Glva Ha Ia )a ,a 4 E�O�a J,a K   a LE` BOa M��,%a N%a O%j Y a PE` BOa Q��,%a R%a S%j O a T��,%a U%j E` VW GX  a Wa Ea Xa Ylva Ha Za )a ,a 4 E�O_ [E` VOa \��,%a ]%a ^%j O a _��,%a `%j E` aW FX  a ba a ca )a ,a  E�O�a ,E` aOa d��,%a e%a f%_ a%a g%j O a h��,%a i%j E` jW FX  a ka a la )a ,a  E�O�a ,E` jOa m��,%a n%a o%_ j%a p%j O �a q��,%a r%j a s  �a tE` uO a v��,%a w%j E` xW wX  a yE�OjvE` xO Fh�a z a {a a |a )a ,a  E�O�a ,E�O�a } �a ~%_ x6FY h[OY��Oa ��,%a �%a �%_ x%a �%j Y 	a �E` uW zX  a �a Ea �a �lva Ha �a )a ,a 4 E�O�a J,a �   a ���,%a �%a �%j Oa �E` uY a ���,%a �%a �%j Oa �E` uO*a �k+ �OPY hOh� �	������� 0 post_cmd  �  �  � ������
� 0 newcmd newCmd� 0 
newelement 
newElement� 0 my2ndcmdstart my2ndCmdStart� 0 my2ndcmdend my2ndCmdEnd� 0 	new2ndcmd 	new2ndCmd�
 0 new2ndelement new2ndElement� '�	�����	�	�	�	�


�
(�
*�
,� 
.����
O
Z
\
g
k
t
v
�
�
�
���
�
�
����	 0 
mycmdstart 
myCmdStart� 0 mycmdend myCmdEnd� 0 mycmd myCmd
� 
cobj
� 
kocl
� .corecnte****       ****� 0 selfcert  � 0 thehost theHost� 0 mybase64url myBase64Url�  0 thevar theVar�� 0 postcmd postCmd�� 0 my2ndcmd my2ndCmd�� 0 	the2ndvar 	the2ndVar
�� .sysoexecTEXT���     TEXT�jvE�OjvE�O��-E�O =�[��l kh �� $�%�%�6FO�� �E�Y hO�%�%�5FY h[OY��O��%�%a %_ %a %�%_ %�%a %E` O_ jv �jvE�OjvE�O_ �-E�O K�[��l kh �a  0a �%a %�6FO�a  
a E�Y hOa �%a %�5FY h[OY��O_ a %�%a %�%a  %_ %a !%�%_ "%�%a #%E` Y hOa $_ %a %%j &� ��
����������� 0 get_xml  ��  ��  � ���� $0 thestatusresults theStatusResults� 
���
���
���
����������������������������� 0 grep_for  �� 0 thehost theHost�� 0 mybase64url myBase64Url
�� .sysoexecTEXT���     TEXT
�� 
cpar
�� 
cobj�� 	
�� 
cwor�� �� 
�� �� �� �� ��  ��  �� ~�E�O��%�%�%�%�%j �-E�O \���/��/Ec  O���/��/Ec  O���/��/Ec  O���/��/Ec  O��a /��/Ec  O��a /��/Ec  W X  hOP� ������������ 0 
set_tplink  �� ����� �  ���� 	0 state  ��  � ������ 	0 state  �� 0 
mydeviceid 
myDeviceid� ��&����������=?�������� 
0 tplink  �� "0 mytplinkdevices myTPLinkDevices
�� 
cwor
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� .sysoexecTEXT���     TEXT��  ��  �� =��  7 + %��-[��l kh �E�O�%�%�%j 	[OY��W X 
 hY h� ��M���������� 0 pwdok pwdOK�� ����� �  ���� 0 thepwd thePwd��  � �������� 0 thepwd thePwd�� 0 pwdchars PWDchars�� 0 ch  � ����������
�� 
cha 
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 0 badpwdchars BadPWDchars�� +��-E�O  �[��l kh Ģ fY h[OY��Oe� ��g���������� ,0 removemarkupfromtext removeMarkupFromText�� ����� �  ���� 0 thetext theText��  � ���������� 0 thetext theText�� 0 tagdetected tagDetected�� 0 a  �� *0 thecurrentcharacter theCurrentCharacter� s��������
�� 
leng
�� 
cha 
�� 
TEXT�� ^fE�O�Ec  O Ik��,Ekh ��/E�O��  eE�Y '��  fE�Y �f  b  �%�&Ec  Y h[OY��Ob  � �����������
�� .aevtoappnull  �   � ****� k    ���  T��  [��  b��  p��  w�� -�� F�� R�� [�� ��� ����  ��  ��  �  � k Y�� `�� g�� u�� ~����59=AD����������bkoy�����������������������������������������������������������&����06��?CF��OSW[^��im��v������������������������������ 0 themacvolume theMacVolume�� 0 thecallvolume theCallVolume�� 0 themutevolume theMuteVolume�� 0 	prefsname 	prefsName
�� 
pnam
�� 
ctxt�� �� 0 badpwdchars BadPWDchars�� 0 my2ndcmd my2ndCmd
�� misccura�� 
0 myname  
�� 
uien�� ,0 isuiscriptingenabled isUIScriptingEnabled
�� .miscactvnull��� ��� null
�� 
appr
�� 
subt�� 
�� .sysonotfnull��� ��� TEXT
�� 
xppb
�� 
xpcp
�� 
xppa
�� .miscmvisnull���     ****
�� 
ret 
�� 
btns
�� 
cbtn
�� 
disp
�� stic   �� 
�� .sysodlogaskr        TEXT
�� .aevtquitnull��� ��� null�� 0 get_prereqs get_PreReqs�� 0 
autoanswer 
AutoAnswer�� 0 get_xml  �� 0 thevar theVar�� 0 	the2ndvar 	the2ndVar�� 0 
set_tplink  �� 0 mycmd myCmd�� 0 post_cmd  
�� 
bool��  ��  �� 0 
get_volume 
get_Volume�� 
0 tplink  �� 0 thecallstatus theCallStatus����E�O�E�O�E�O�E�O��  )�,�&E�Y hO�����a vE` OjvE` Oa �,�&E` O_ a   hY �_ a   a E` Y hOa  *a ,E` UO_ f  �a  �*j Oa a )�,�&a a  a ! "O*a #a $/*a %,FO*a %, *a &a '/j (UO*j Oa )_ *%_ *%a +%_ *%_ *%a ,%_ *%a -%_ *%a .%_ %a /%_ *%a 0%a )�,a 1a 2kva 3a 4a 5a 6a 7 8O*j 9UY hO*a :k+ ;O_ <a =  � �*j+ >Ob  a ? Va @E` AO�E` BOa CEc  O*a Dk+ EOa Fa Ga HmvE` IOa Ja Ka La Ma Na vE` O*j+ OOhY sb  a P
 b  a Qa R& 6*a Sk+ EO�E` AOa Ta Ua Va Wa Xa vE` IO*j+ OOhOPY #b  a Y a ZEc  Y a [Ec  W X \ ]a ^Ec  O*j+ _Y �_ <a `  |*j+ >O_ aa b  b N_ ca d
 _ ca ea R&
 _ ca fa R&
 _ ca ga R& a hEc  Y a iEc  W X \ ]a jEc  Y hO*j+ _Y h ascr  ��ޭ