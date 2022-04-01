FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l      	 
  	 x     ��  ��    1      ��
�� 
ascr  �� ��
�� 
minv  m         �    2 . 4��   
 L F Yosemite (10.10) or later -- tested on OS X 12.3 Montery 1 April 2022     �   �   Y o s e m i t e   ( 1 0 . 1 0 )   o r   l a t e r   - -   t e s t e d   o n   O S   X   1 2 . 3   M o n t e r y   1   A p r i l   2 0 2 2      x    �� ����    2  	 ��
�� 
osax��        l     ��������  ��  ��        l      ��  ��   D>

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
     �  | 
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
      l     ��������  ��  ��        l      ��   !��       INSTRUCTIONS     ! � " "    I N S T R U C T I O N S     # $ # l     ��������  ��  ��   $  % & % l      �� ' (��   ' L F USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND     ( � ) ) �   U S E D   F O R   T E S T I N G   T O T A L   T I M E   T O   E X E C U T E   T H E   S C R I P T   T O   T H E   M I L L I S E C O N D   &  * + * l      �� , -��   , P J Lines at the end of the script also have to be commented out or included     - � . . �   L i n e s   a t   t h e   e n d   o f   t h e   s c r i p t   a l s o   h a v e   t o   b e   c o m m e n t e d   o u t   o r   i n c l u d e d   +  / 0 / l     �� 1 2��   1 H Bset mgRightNow to "perl -e 'use Time::HiRes qw(time); print time'"    2 � 3 3 � s e t   m g R i g h t N o w   t o   " p e r l   - e   ' u s e   T i m e : : H i R e s   q w ( t i m e ) ;   p r i n t   t i m e ' " 0  4 5 4 l     �� 6 7��   6 / )set mgStart to do shell script mgRightNow    7 � 8 8 R s e t   m g S t a r t   t o   d o   s h e l l   s c r i p t   m g R i g h t N o w 5  9 : 9 l     ��������  ��  ��   :  ; < ; l      �� = >��   = 4 . ############################################     > � ? ? \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   <  @ A @ l      �� B C��   B 8 2 ################ USER VARIABLES ################     C � D D d   # # # # # # # # # # # # # # # #   U S E R   V A R I A B L E S   # # # # # # # # # # # # # # # #   A  E F E l      �� G H��   G 4 . ############################################     H � I I \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   F  J K J l      �� L M��   L ` Z set different volume levels to match your specific requirements by changing these values     M � N N �   s e t   d i f f e r e n t   v o l u m e   l e v e l s   t o   m a t c h   y o u r   s p e c i f i c   r e q u i r e m e n t s   b y   c h a n g i n g   t h e s e   v a l u e s   K  O P O l     Q���� Q r      R S R m      T T � U U  2 5 S o      ���� 0 themacvolume theMacVolume��  ��   P  V W V l    X���� X r     Y Z Y m     [ [ � \ \  6 0 Z o      ���� 0 thecallvolume theCallVolume��  ��   W  ] ^ ] l    _���� _ r     ` a ` m    	 b b � c c  0 a o      ���� 0 themutevolume theMuteVolume��  ��   ^  d e d l     ��������  ��  ��   e  f g f l      �� h i��   h�� prefsName is the variable for preference panes and keychain naming for user preferences and securityfor example if set to TESTME the preference pane would be com.cisco.TESTME and the keychain entry would be TESTME.<DESKPRO_USER> . You can safely change this to anything you want the preferences and keychain to show up as. If you do not set this variable the default of the script name will be used     i � j j    p r e f s N a m e   i s   t h e   v a r i a b l e   f o r   p r e f e r e n c e   p a n e s   a n d   k e y c h a i n   n a m i n g   f o r   u s e r   p r e f e r e n c e s   a n d   s e c u r i t y f o r   e x a m p l e   i f   s e t   t o   T E S T M E   t h e   p r e f e r e n c e   p a n e   w o u l d   b e   c o m . c i s c o . T E S T M E   a n d   t h e   k e y c h a i n   e n t r y   w o u l d   b e   T E S T M E . < D E S K P R O _ U S E R >   .   Y o u   c a n   s a f e l y   c h a n g e   t h i s   t o   a n y t h i n g   y o u   w a n t   t h e   p r e f e r e n c e s   a n d   k e y c h a i n   t o   s h o w   u p   a s .   I f   y o u   d o   n o t   s e t   t h i s   v a r i a b l e   t h e   d e f a u l t   o f   t h e   s c r i p t   n a m e   w i l l   b e   u s e d   g  k l k l    m���� m r     n o n m     p p � q q , D e s k p r o   V o l u m e   U t i l i t y o o      ���� 0 	prefsname 	prefsName��  ��   l  r s r l   ! t���� t Z    ! u v���� u =    w x w o    ���� 0 	prefsname 	prefsName x m     y y � z z   v r     { | { c     } ~ } n     �  1    ��
�� 
pnam �  f     ~ m    ��
�� 
ctxt | o      ���� 0 	prefsname 	prefsName��  ��  ��  ��   s  � � � l     ��������  ��  ��   �  � � � l      �� � ���   � 4 . ############################################     � � � � \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   �  � � � l      �� � ���   � 9 3 ############# END OF USER VARIABLES #############     � � � � f   # # # # # # # # # # # # #   E N D   O F   U S E R   V A R I A B L E S   # # # # # # # # # # # # #   �  � � � l      �� � ���   � 4 . ############################################     � � � � \   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   �  � � � l     ��������  ��  ��   �  � � � l      �� � ���   �   NO CHANGES BELOW HERE     � � � � .   N O   C H A N G E S   B E L O W   H E R E   �  � � � l     ��������  ��  ��   �  � � � l      �� � ���   � 7 1 Make variables globally available to the script     � � � � b   M a k e   v a r i a b l e s   g l o b a l l y   a v a i l a b l e   t o   t h e   s c r i p t   �  � � � l     ��������  ��  ��   �  � � � j    �� ��� 0 
mutestatus 
muteStatus � m     � � � � �   �  � � � j    �� ��� 0 thecurrvolume theCurrVolume � m     � � � � �   �  � � � j    �� ��� 0 answeredstate answeredState � m     � � � � �   �  � � � j    �� ��� 0 callduration callDuration � m     � � � � �   �  � � � j    !�� ��� 0 	thevolume 	theVolume � m      � � � � �   �  � � � j   " $�� ��� 0 
callstatus 
callStatus � m   " # � � � � �   �  � � � j   % )�� ��� 0 
thevolmute 
theVolMute � m   % ( � � � � �   �  � � � j   * .�� ��� 0 thecleantext theCleanText � m   * - � � � � �   �  � � � l     ��������  ��  ��   �  � � � p   / / � � ������ 0 thehost theHost��   �  � � � p   / / � � ������ 0 theend theEnd��   �  � � � p   / / � � ������ 0 theuser theUser��   �  � � � p   / / � � ������ 0 thepwd thePwd��   �  � � � p   / / � � ������ 0 themacvolume theMacVolume��   �  � � � p   / / � � ������ 0 thecallvolume theCallVolume��   �  � � � p   / / � � ������ 0 themutevolume theMuteVolume��   �  � � � p   / / � � ������ 0 badpwdchars BadPWDchars��   �  � � � p   / / � � ������ 0 trypwd tryPWD��   �  � � � p   / / � � ������ 0 	prefsname 	prefsName��   �  � � � p   / / � � ������ 0 micstate micState��   �  � � � p   / / � � ������ 0 
autoanswer 
AutoAnswer��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � p   / / � � ������ 
0 tplink  ��   �  � � � p   / / � � ������ "0 mytplinkdevices myTPLinkDevices��   �  � � � p   / / � � ������  0 newkasadevices newKasaDevices��   �  � � � p   / / � � ������ 0 myuuidv4 myUUIDv4��   �    p   / / ������ 0 mybase64url myBase64Url��    l     ��������  ��  ��    p   / / ��~� 0 getcmd getCmd�~   	 p   / /

 �}�|�} 0 grep_for  �|  	  p   / / �{�z�{ 0 thevar theVar�z    p   / / �y�x�y 0 	the2ndvar 	the2ndVar�x    p   / / �w�v�w 0 
mycmdstart 
myCmdStart�v    p   / / �u�t�u 0 mycmdend myCmdEnd�t    p   / / �s�r�s 0 mycmd myCmd�r    p   / / �q�p�q 0 my2ndcmd my2ndCmd�p    p   / / �o�n�o 0 postcmd postCmd�n    !  p   / /"" �m�l�m 0 	currvalue 	currValue�l  ! #$# p   / /%% �k�j�k 0 selfcert  �j  $ &'& l     �i�h�g�i  �h  �g  ' ()( l  " /*�f�e* r   " /+,+ J   " +-- ./. m   " #00 �11  !/ 232 m   # $44 �55  [3 676 m   $ %88 �99  ]7 :;: m   % &<< �==  {; >�d> m   & '?? �@@  }�d  , o      �c�c 0 badpwdchars BadPWDchars�f  �e  ) ABA l  0 6C�b�aC r   0 6DED J   0 2�`�`  E o      �_�_ 0 my2ndcmd my2ndCmd�b  �a  B FGF l     �^�]�\�^  �]  �\  G HIH l     �[JK�[  J . ( Walk user though enabling UI automation   K �LL P   W a l k   u s e r   t h o u g h   e n a b l i n g   U I   a u t o m a t i o nI MNM l  7 BO�Z�YO r   7 BPQP c   7 >RSR n   7 <TUT 1   : <�X
�X 
pnamU m   7 :�W
�W misccuraS m   < =�V
�V 
ctxtQ o      �U�U 
0 myname  �Z  �Y  N VWV l  C5X�T�SX Z   C5Y�R�QZY =  C J[\[ o   C F�P�P 
0 myname  \ m   F I]] �^^ " r u n m e _ i n s t a l l _ D V U�R  �Q  Z k   Q5__ `a` Z   Q fbc�O�Nb =  Q Xded o   Q T�M�M 
0 myname  e m   T Wff �gg  o s a s c r i p tc r   [ bhih m   [ ^jj �kk  S c r i p t   M e n ui o      �L�L 
0 myname  �O  �N  a lml l  g g�K�J�I�K  �J  �I  m non O  g wpqp r   m vrsr 1   m r�H
�H 
uiens o      �G�G ,0 isuiscriptingenabled isUIScriptingEnabledq m   g jtt�                                                                                  sevs  alis    T  BigSurHD                       BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    B i g S u r H D  -System/Library/CoreServices/System Events.app   / ��  o u�Fu Z   x5vw�E�Dv =   x }xyx o   x {�C�C ,0 isuiscriptingenabled isUIScriptingEnabledy m   { |�B
�B boovfalsw O   �1z{z k   �0|| }~} I  � ��A�@�?
�A .miscactvnull��� ��� null�@  �?  ~ � I  � ��>��
�> .sysonotfnull��� ��� TEXT� m   � ��� ��� V P l e a s e   f o l l o w   i n s t r u c t i o n s   w h e n   t h e y   a p p e a r� �=��
�= 
appr� c   � ���� l  � ���<�;� n   � ���� 1   � ��:
�: 
pnam�  f   � ��<  �;  � m   � ��9
�9 
ctxt� �8��7
�8 
subt� m   � ��� ��� R L o a d i n g   S e c u r i t y   &   P r i v a c y   P r e f e r e n c e s . . .�7  � ��� r   � ���� 4   � ��6�
�6 
xppb� m   � ��� ��� : c o m . a p p l e . p r e f e r e n c e . s e c u r i t y� 1   � ��5
�5 
xpcp� ��� O  � ���� I  � ��4��3
�4 .miscmvisnull���     ****� 4   � ��2�
�2 
xppa� m   � ��� ��� * P r i v a c y _ A c c e s s i b i l i t y�3  � 1   � ��1
�1 
xpcp� ��� l  � ��0���0  � : 4 Activate again so the dialog box will appear on top   � ��� h   A c t i v a t e   a g a i n   s o   t h e   d i a l o g   b o x   w i l l   a p p e a r   o n   t o p� ��� I  � ��/�.�-
�/ .miscactvnull��� ��� null�.  �-  � ��� I  �*�,��
�, .sysodlogaskr        TEXT� b   �
��� b   ���� b   ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� | Y o u r   s y s t e m   n e e d s   a   o n e - t i m e   c o n f i g u r a t i o n   t o   r u n   t h i s   s c r i p t .� o   � ��+
�+ 
ret � o   � ��*
�* 
ret � m   � ��� ��� x I n   " S y s t e m   P r e f e r e n c e s . . .   - >   S e c u r i t y   &   P r i v a c y   - >   P r i v a c y " :� o   � ��)
�) 
ret � o   � ��(
�( 
ret � m   � ��� ��� T 1 .   U n l o c k   " C l i c k   t h e   l o c k   t o   m a k e   c h a n g e s "� o   � ��'
�' 
ret � m   � ��� ��� > 2 .   S e l e c t   " C l i c k   A c c e s s i b i l i t y "� o   � ��&
�& 
ret � m   � ��� ��� : 3 .   S e l e c t   c h e c k b o x   n e x t   t o :   "� o   � ��%�% 
0 myname  � m   ��� ���  "� o  �$
�$ 
ret � m  	�� ��� @ 4 .   R e - r u n   t h e   s c r i p t   t o   p r o c e e d .� �#��
�# 
appr� n  ��� 1  �"
�" 
pnam�  f  � �!��
�! 
btns� J  �� �� � m  �� ���  O K�   � ���
� 
cbtn� m  �� ���  O K� ���
� 
disp� m  !$�
� stic   �  � ��� I +0���
� .aevtquitnull��� ��� null�  �  �  { m   � ����                                                                                  sprf  alis    X  BigSurHD                       BD ����System Preferences.app                                         ����            ����  
 cu             Applications  -/:System:Applications:System Preferences.app/   .  S y s t e m   P r e f e r e n c e s . a p p    B i g S u r H D  *System/Applications/System Preferences.app  / ��  �E  �D  �F  �T  �S  W ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l 6>���� I  6>���� 0 get_prereqs get_PreReqs� ��� m  7:�� ���  g e t P r e f s�  �  �  �  � ��� l     ���
�  �  �
  � ��� l      �	���	  � � �If Auto Answer was selected check to see if there is an incoming call, If so answer it; check if connected or in some state of connecting; set the tplink to the correct state, set the volume to in call level   � ���� I f   A u t o   A n s w e r   w a s   s e l e c t e d   c h e c k   t o   s e e   i f   t h e r e   i s   a n   i n c o m i n g   c a l l ,   I f   s o   a n s w e r   i t ;   c h e c k   i f   c o n n e c t e d   o r   i n   s o m e   s t a t e   o f   c o n n e c t i n g ;   s e t   t h e   t p l i n k   t o   t h e   c o r r e c t   s t a t e ,   s e t   t h e   v o l u m e   t o   i n   c a l l   l e v e l� ��� l     ����  � # on get_AutoAnswer(AutoAnswer)   � ��� : o n   g e t _ A u t o A n s w e r ( A u t o A n s w e r )� ��� l      ����  � z t check to see if the Deskpro is ringing, if so answer it and set the tplink  to on, set the volume to in call level    � ��� �   c h e c k   t o   s e e   i f   t h e   D e s k p r o   i s   r i n g i n g ,   i f   s o   a n s w e r   i t   a n d   s e t   t h e   t p l i n k     t o   o n ,   s e t   t h e   v o l u m e   t o   i n   c a l l   l e v e l  �    l ?��� Z  ?�� = ?F o  ?B�� 0 
autoanswer 
AutoAnswer m  BE �		  Y e s k  I:

  Q  I4 k  L#  I  LQ��� � 0 get_xml  �  �    �� Z  R# E  R[ o  RW���� 0 
callstatus 
callStatus m  WZ �  R i n g i n g k  ^�  r  ^e  m  ^a!! �""    o      ���� 0 thevar theVar #$# r  fk%&% o  fg���� 0 thecallvolume theCallVolume& o      ���� 0 	the2ndvar 	the2ndVar$ '(' r  lu)*) m  lo++ �,,  1* o      ���� 0 
callstatus 
callStatus( -.- I  v~��/���� 0 
set_tplink  / 0��0 m  wz11 �22  o n��  ��  . 343 r  �565 J  �77 898 m  �:: �;;  C o m m a n d9 <=< m  ��>> �??  C a l l= @��@ m  ��AA �BB  A c c e p t��  6 o      ���� 0 mycmd myCmd4 CDC r  ��EFE J  ��GG HIH m  ��JJ �KK  C o m m a n dI LML m  ��NN �OO 
 A u d i oM PQP m  ��RR �SS  V o l u m eQ TUT m  ��VV �WW $ S e t   c o m m a n d = " T r u e "U X��X m  ��YY �ZZ 
 L e v e l��  F o      ���� 0 my2ndcmd my2ndCmdD [\[ I  ���������� 0 post_cmd  ��  ��  \ ]��] L  ������  ��   ^_^ G  ��`a` E  ��bcb o  ������ 0 
callstatus 
callStatusc m  ��dd �ee  C o n n e c t i n ga E  ��fgf o  ������ 0 
callstatus 
callStatusg m  ��hh �ii  D i a l l i n g_ jkj k  ��ll mnm I  ����o���� 0 
set_tplink  o p��p m  ��qq �rr  o n��  ��  n sts r  ��uvu o  ������ 0 thecallvolume theCallVolumev o      ���� 0 thevar theVart wxw r  ��yzy J  ��{{ |}| m  ��~~ �  C o m m a n d} ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  V o l u m e� ��� m  ���� ��� $ S e t   c o m m a n d = " T r u e "� ���� m  ���� ��� 
 L e v e l��  z o      ���� 0 mycmd myCmdx ��� I  ���������� 0 post_cmd  ��  ��  � ��� L  ������  � ���� l ��������  �  	set callStatus to "1"   � ��� , 	 s e t   c a l l S t a t u s   t o   " 1 "��  k ��� E  ��� o  ���� 0 
callstatus 
callStatus� m  
�� ���  C o n n e c t e d� ���� r  ��� m  �� ���  1� o      ���� 0 
callstatus 
callStatus��   r  #��� m  �� ���  0� o      ���� 0 
callstatus 
callStatus��   R      ������
�� .ascrerr ****      � ****��  ��   r  +4��� m  +.�� ���  0� o      ���� 0 
callstatus 
callStatus ���� I  5:�������� 0 
get_volume 
get_Volume��  ��  ��   ��� = =D��� o  =@���� 0 
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
get_Volume��  ��  ��  ��  �  �  �   ��� l     ��������  ��  ��  � ��� l      ������  � ^ Xget the current volume state, toggle between call and Mac volume, allow volume selection   � ��� � g e t   t h e   c u r r e n t   v o l u m e   s t a t e ,   t o g g l e   b e t w e e n   c a l l   a n d   M a c   v o l u m e ,   a l l o w   v o l u m e   s e l e c t i o n� ��� i   / 2��� I      �������� 0 
get_volume 
get_Volume��  ��  � k    _�� ��� Z    C������ =    ��� o     ���� 0 
callstatus 
callStatus� m    �� ���  0� k   
 ��� ��� I   
 ������� 0 
set_tplink  � ���� m       �  o f f��  ��  �  Q    # l   ���� I    �������� 0 get_xml  ��  ��  ��  ��   R      ������
�� .ascrerr ****      � ****��  ��   L   ! #����   	 Z   $ q
��
 A  $ + o   $ )���� 0 thecurrvolume theCurrVolume o   ) *���� 0 thecallvolume theCallVolume r   . I I  . G��
�� .sysodlogaskr        TEXT m   . / � B 	 	 	 	 S e l e c t   y o u r   v o l u m e   p r e f e r e n c e ��
�� 
btns J   0 5  m   0 1 �  M u t e  m   1 2 �  I n   C a l l  ��  m   2 3!! �""  M a c��   ��#$
�� 
dflt# m   6 7%% �&&  I n   C a l l$ ��'(
�� 
givu' m   8 9���� ( ��)��
�� 
appr) n   < A*+* 1   = A��
�� 
pnam+  f   < =��   o      ���� 0 b  ��   l  L q,-., r   L q/0/ I  L o��12
�� .sysodlogaskr        TEXT1 m   L O33 �44 B 	 	 	 	 S e l e c t   y o u r   v o l u m e   p r e f e r e n c e2 ��56
�� 
btns5 J   P [77 898 m   P S:: �;;  M u t e9 <=< m   S V>> �??  I n   C a l l= @��@ m   V YAA �BB  M a c��  6 ��CD
�� 
dfltC m   \ _EE �FF  M a cD ��GH
�� 
givuG m   ` a���� H ��I��
�� 
apprI n   d iJKJ 1   e i��
�� 
pnamK  f   d e��  0 o      ���� 0 b  - 6 0 if currVolume is greater than theMacVolume then   . �LL `   i f   c u r r V o l u m e   i s   g r e a t e r   t h a n   t h e M a c V o l u m e   t h e n	 M��M Z   r �NOPQN =  r {RSR n   r wTUT 1   s w��
�� 
bhitU o   r s���� 0 b  S m   w zVV �WW  M a cO r   ~ �XYX o   ~ ����� 0 themacvolume theMacVolumeY o      ���� 0 thevar theVarP Z[Z =  � �\]\ n   � �^_^ 1   � ���
�� 
bhit_ o   � ����� 0 b  ] m   � �`` �aa  I n   C a l l[ bcb r   � �ded o   � ����� 0 thecallvolume theCallVolumee o      ���� 0 thevar theVarc fgf =  � �hih n   � �jkj 1   � ���
�� 
bhitk o   � ����� 0 b  i m   � �ll �mm  M u t eg n��n r   � �opo o   � ����� 0 themutevolume theMuteVolumep o      ���� 0 thevar theVar��  Q R   � �����q
�� .ascrerr ****      � ****��  q �r�~
� 
errnr m   � ��}�}���~  ��  � sts =  � �uvu o   � ��|�| 0 
callstatus 
callStatusv m   � �ww �xx  1t y�{y k   �?zz {|{ I   � ��z}�y�z 0 
set_tplink  } ~�x~ m   � � ���  o n�x  �y  | ��w� Q   �?���� k   �-�� ��� r   � ���� m   � ��� ���  � o      �v�v 0 thevar theVar� ��� r   � ���� m   � ��� ���  � o      �u�u 0 	the2ndvar 	the2ndVar� ��� Z   ����t�s� A  � ���� o   � ��r�r 0 callduration callDuration� m   � ��� ���  3 0� k   ��� ��� r   � ���� o   � ��q�q 0 thecallvolume theCallVolume� o      �p�p 0 thevar theVar� ��� r   ���� J   �
�� ��� m   � ��� ���  C o m m a n d� ��� m   � ��� ��� 
 A u d i o� ��� m   ��� ���  V o l u m e� ��� m  �� ��� $ S e t   c o m m a n d = " T r u e "� ��o� m  �� ��� 
 L e v e l�o  � o      �n�n 0 mycmd myCmd� ��m� I  �l�k�j�l 0 post_cmd  �k  �j  �m  �t  �s  � ��� Z  �����i� F  2��� = "��� o  �h�h 0 
mutestatus 
muteStatus� m  !�� ���  O n� = %.��� o  %*�g�g 0 
thevolmute 
theVolMute� m  *-�� ���  O n� l 5Z���� r  5Z��� I 5X�f��
�f .sysodlogaskr        TEXT� m  58�� ��� > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e� �e��
�e 
btns� J  9D�� ��� m  9<�� ���  U n M u t e   V o l� ��� m  <?�� ���  U n M u t e   A l l� ��d� m  ?B�� ���  D i s c o n n e c t�d  � �c��
�c 
dflt� m  EH�� ���  U n M u t e   A l l� �b��
�b 
givu� m  IJ�a�a � �`��_
�` 
appr� n  MR��� 1  NR�^
�^ 
pnam�  f  MN�_  � o      �]�] 0 b  � H B option 1 mic and vol are both muted, unmute volume or unmute both   � ��� �   o p t i o n   1   m i c   a n d   v o l   a r e   b o t h   m u t e d ,   u n m u t e   v o l u m e   o r   u n m u t e   b o t h� ��� F  ]���� = ]f��� o  ]b�\�\ 0 
mutestatus 
muteStatus� m  be�� ���  O n� l i���[�Z� F  i���� = ir��� o  in�Y�Y 0 
thevolmute 
theVolMute� m  nq�� ���  O f f� @ u|��� o  uz�X�X 0 thecurrvolume theCurrVolume� o  z{�W�W 0 thecallvolume theCallVolume�[  �Z  � ��� l ������ r  ����� I ���V 
�V .sysodlogaskr        TEXT  m  �� � > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e �U
�U 
btns J  ��  m  ��		 �

  U n M u t e   M i c  m  �� �  M u t e   V o l �T m  �� �  D i s c o n n e c t�T   �S
�S 
dflt m  �� �  U n M u t e   M i c �R
�R 
givu m  ���Q�Q  �P�O
�P 
appr n  �� 1  ���N
�N 
pnam  f  ���O  � o      �M�M 0 b  � b \ option 2 mic is muted volume is not, option to unmute mic or mute vol so that both are mute   � � �   o p t i o n   2   m i c   i s   m u t e d   v o l u m e   i s   n o t ,   o p t i o n   t o   u n m u t e   m i c   o r   m u t e   v o l   s o   t h a t   b o t h   a r e   m u t e�  F  �� = �� !  o  ���L�L 0 
mutestatus 
muteStatus! m  ��"" �##  O n l ��$�K�J$ F  ��%&% = ��'(' o  ���I�I 0 
thevolmute 
theVolMute( m  ��)) �**  O f f& A ��+,+ o  ���H�H 0 thecurrvolume theCurrVolume, o  ���G�G 0 thecallvolume theCallVolume�K  �J   -.- l ��/01/ r  ��232 I ���F45
�F .sysodlogaskr        TEXT4 m  ��66 �77 > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e5 �E89
�E 
btns8 J  ��:: ;<; m  ��== �>>  U n M u t e   M i c< ?@? m  ��AA �BB  M u t e   A l l@ C�DC m  ��DD �EE  D i s c o n n e c t�D  9 �CFG
�C 
dfltF m  ��HH �II  U n M u t e   M i cG �BJK
�B 
givuJ m  ���A�A K �@L�?
�@ 
apprL n  ��MNM 1  ���>
�> 
pnamN  f  ���?  3 o      �=�= 0 b  0 o i option 3 mic is muted volume is lower that thecallvolume but not mute, option to unmute mic or mute all    1 �OO �   o p t i o n   3   m i c   i s   m u t e d   v o l u m e   i s   l o w e r   t h a t   t h e c a l l v o l u m e   b u t   n o t   m u t e ,   o p t i o n   t o   u n m u t e   m i c   o r   m u t e   a l l  . PQP F  (RSR = 
TUT o  �<�< 0 
mutestatus 
muteStatusU m  	VV �WW  O f fS l $X�;�:X F  $YZY = [\[ o  �9�9 0 
thevolmute 
theVolMute\ m  ]] �^^  O nZ A  _`_ o  �8�8 0 thecurrvolume theCurrVolume` o  �7�7 0 thecallvolume theCallVolume�;  �:  Q aba l +Pcdec r  +Pfgf I +N�6hi
�6 .sysodlogaskr        TEXTh m  +.jj �kk > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c ei �5lm
�5 
btnsl J  /:nn opo m  /2qq �rr  M u t e   M i cp sts m  25uu �vv  U n M u t e   A l lt w�4w m  58xx �yy  D i s c o n n e c t�4  m �3z{
�3 
dfltz m  ;>|| �}}  U n M u t e   A l l{ �2~
�2 
givu~ m  ?@�1�1  �0��/
�0 
appr� n  CH��� 1  DH�.
�. 
pnam�  f  CD�/  g o      �-�- 0 b  d j d option 4 if for some reason the mic is not mute but the volume is, option to mute mic or unmute all   e ��� �   o p t i o n   4   i f   f o r   s o m e   r e a s o n   t h e   m i c   i s   n o t   m u t e   b u t   t h e   v o l u m e   i s ,   o p t i o n   t o   m u t e   m i c   o r   u n m u t e   a l lb ��� F  Sl��� = S\��� o  SX�,�, 0 
mutestatus 
muteStatus� m  X[�� ���  O f f� = _h��� o  _d�+�+ 0 
thevolmute 
theVolMute� m  dg�� ���  O f f� ��*� l o����� r  o���� I o��)��
�) .sysodlogaskr        TEXT� m  or�� ��� > 	 	 	 	 S e l e c t   y o u r   m u t e   p r e f e r e n c e� �(��
�( 
btns� J  s~�� ��� m  sv�� ���  M u t e   M i c� ��� m  vy�� ���  M u t e   A l l� ��'� m  y|�� ���  D i s c o n n e c t�'  � �&��
�& 
dflt� m  ��� ���  M u t e   M i c� �%��
�% 
givu� m  ���$�$ � �#��"
�# 
appr� n  ����� 1  ���!
�! 
pnam�  f  ���"  � o      � �  0 b  � P J option 5 neither mic and volume are mute, option to mute mic or mute all    � ��� �   o p t i o n   5   n e i t h e r   m i c   a n d   v o l u m e   a r e   m u t e ,   o p t i o n   t o   m u t e   m i c   o r   m u t e   a l l  �*  �i  � ��� Z  �-����� = ����� n  ����� 1  ���
� 
bhit� o  ���� 0 b  � m  ���� ���  U n M u t e   M i c� k  ���� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  M i c r o p h o n e s� ��� m  ���� ���  U n M u t e�  � o      �� 0 mycmd myCmd� ��� I  ������ 0 post_cmd  �  �  � ��� L  ����  �  � ��� = ����� n  ����� 1  ���
� 
bhit� o  ���� 0 b  � m  ���� ���  U n M u t e   V o l� ��� k  ���� ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  V o l u m e� ��� m  ���� ���  U n M u t e�  � o      �� 0 mycmd myCmd� ��� I  ������ 0 post_cmd  �  �  � ��� L  ����  �  � ��� = ����� n  ����� 1  ���
� 
bhit� o  ���� 0 b  � m  ���� ���  U n M u t e   A l l� � � k  �/  r  � J  �  m  � 		 �

  C o m m a n d  m    � 
 A u d i o  m   �  M i c r o p h o n e s �
 m  	 �  U n M u t e�
   o      �	�	 0 mycmd myCmd  r  & J  "  m   �  C o m m a n d   m  !! �"" 
 A u d i o  #$# m  %% �&&  V o l u m e$ '�' m  (( �))  U n M u t e�   o      �� 0 my2ndcmd my2ndCmd *+* I  ',���� 0 post_cmd  �  �  + ,�, L  -/��  �    -.- = 2;/0/ n  27121 1  37�
� 
bhit2 o  23� �  0 b  0 m  7:33 �44  M u t e   M i c. 565 k  >[77 898 r  >R:;: J  >N<< =>= m  >A?? �@@  C o m m a n d> ABA m  ADCC �DD 
 A u d i oB EFE m  DGGG �HH  M i c r o p h o n e sF I��I m  GJJJ �KK  M u t e��  ; o      ���� 0 mycmd myCmd9 LML I  SX�������� 0 post_cmd  ��  ��  M N��N L  Y[����  ��  6 OPO = ^gQRQ n  ^cSTS 1  _c��
�� 
bhitT o  ^_���� 0 b  R m  cfUU �VV  M u t e   V o lP WXW k  j�YY Z[Z r  j~\]\ J  jz^^ _`_ m  jmaa �bb  C o m m a n d` cdc m  mpee �ff 
 A u d i od ghg m  psii �jj  V o l u m eh k��k m  svll �mm  M u t e��  ] o      ���� 0 mycmd myCmd[ non I  ��������� 0 post_cmd  ��  ��  o p��p L  ������  ��  X qrq = ��sts n  ��uvu 1  ����
�� 
bhitv o  ������ 0 b  t m  ��ww �xx  M u t e   A l lr yzy k  ��{{ |}| r  ��~~ J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  M i c r o p h o n e s� ���� m  ���� ���  M u t e��   o      ���� 0 mycmd myCmd} ��� r  ����� J  ���� ��� m  ���� ���  C o m m a n d� ��� m  ���� ��� 
 A u d i o� ��� m  ���� ���  V o l u m e� ���� m  ���� ���  M u t e��  � o      ���� 0 my2ndcmd my2ndCmd� ��� I  ���������� 0 post_cmd  ��  ��  � ���� L  ������  ��  z ��� = ����� n  ����� 1  ����
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
errn� m  '*��������  �  � R      ������
�� .ascrerr ****      � ****��  ��  � R  5?�����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  9<��������  �w  �{  ��  � ��� r  DY��� J  DU�� ��� m  DG�� ���  C o m m a n d� ��� m  GJ�� ��� 
 A u d i o� ��� m  JM�� �    V o l u m e�  m  MP � $ S e t   c o m m a n d = " T r u e " �� m  PS � 
 L e v e l��  � o      ���� 0 mycmd myCmd� �� I  Z_�������� 0 post_cmd  ��  ��  ��  � 	
	 l     ��������  ��  ��  
  l      ����   : 4 get the prerequisite user variables for the script     � h   g e t   t h e   p r e r e q u i s i t e   u s e r   v a r i a b l e s   f o r   t h e   s c r i p t    i   3 6 I      ������ 0 get_prereqs get_PreReqs �� o      ���� 
0 action  ��  ��   k    �  Z    ����� =     o     ���� 
0 action   m     �  g e t P r e f s k   �  !  Q    �"#$" l  	 %&'% r   	 ()( I  	 ��*��
�� .sysoexecTEXT���     TEXT* b   	 +,+ b   	 -.- m   	 
// �00 0 d e f a u l t s   r e a d   c o m . c i s c o .. n   
 121 1    ��
�� 
strq2 o   
 ���� 0 	prefsname 	prefsName, m    33 �44    h o s t n a m e��  ) o      ���� 0 thehost theHost& F @ check to see if a hostname has been previously saved and use it   ' �55 �   c h e c k   t o   s e e   i f   a   h o s t n a m e   h a s   b e e n   p r e v i o u s l y   s a v e d   a n d   u s e   i t# R      ������
�� .ascrerr ****      � ****��  ��  $ l   �6786 k    �99 :;: I   s��<=
�� .sysodlogaskr        TEXT< b    g>?> b    c@A@ b    aBCB b    _DED b    [FGF b    YHIH b    WJKJ b    SLML b    QNON b    MPQP b    KRSR b    GTUT b    EVWV b    CXYX b    ?Z[Z b    =\]\ b    ;^_^ b    7`a` b    5bcb b    3ded b    1fgf b    /hih b    -jkj b    +lml b    )non b    'pqp b    %rsr b    #tut b    !vwv m    xx �yy ^ T h e   S c r i p t   w a s   u n a b l e   t o   r e a d   y o u r   p r e f e r e n c e s .w l 
   z����z o     ��
�� 
ret ��  ��  u m   ! "{{ �|| t P l e a s e   h a v e   t h e   f o l l o w i n g   i n f o r m a t i o n   a v a i l a b l e   f o r   i n p u t .s o   # $��
�� 
ret q l 
 % &}����} o   % &��
�� 
ret ��  ��  o m   ' (~~ � > D e s k p r o   h o s t n a m e   o r   I P   a d d r e s s :m l 
 ) *������ o   ) *��
�� 
ret ��  ��  k m   + ,�� ��� " D e s k p r o   U s e r n a m e :i o   - .��
�� 
ret g m   / 0�� ��� 4 D e s k p r o   p a s s w o r d   f o r   u s e r :e l 
 1 2������ o   1 2��
�� 
ret ��  ��  c m   3 4�� ��� > I g n o r e   S e l f   S i g n e d   C e r t   Y e s / N o :a o   5 6��
�� 
ret _ m   7 :�� ��� 2 A u t o   A n s w e r   C a l l s   Y e s / N o :] o   ; <��
�� 
ret [ l 
 = >������ o   = >��
�� 
ret ��  ��  Y m   ? B�� ��� ^ I f   y o u   w a n t   t o   c o n t r o l   a   T P - L i n k   D e v i c e :   Y e s / N oW o   C D��
�� 
ret U l 
 E F������ o   E F��
�� 
ret ��  ��  S m   G J�� ��� � I f   y o u   s e l e c t e d   y e s   t o   c o n t r o l   t h e   T P - L i n k   D e v i c e   y o u   w i l l   n e e d :Q l 
 K L������ o   K L��
�� 
ret ��  ��  O m   M P�� ���   T P - L i n k   K A S A   I D :M o   Q R��
�� 
ret K m   S V�� ��� * T P - L i n k   D e v i c e   I D ( s ) :I o   W X��
�� 
ret G l 
 Y Z������ o   Y Z��
�� 
ret ��  ��  E m   [ ^�� ��� � Y o u   c a n   s e l e c t   " C a n c e l "   i f   y o u   d o   n o t   h a v e   t h i s   i n f o r m a t i o n   a v a i l a b l e   n o w .C o   _ `��
�� 
ret A l 
 a b������ o   a b��
�� 
ret ��  ��  ? m   c f�� ��� � I n s t r u c t i o n s   a r e   l o c a t e d   a t   t h e   t o p   o f   t h e   s c r i p t ,   o p e n   w i t h   a   t e x t   a p p l i c a t i o n   o r   s c r i p t   e d i t o r   t o   r e a d .= �����
�� 
appr� n   j o��� 1   k o��
�� 
pnam�  f   j k��  ; ��� r   t ���� I  t �����
�� .sysodlogaskr        TEXT� l  t w������ m   t w�� ��� X W h a t   i s   y o u r   D e s k p r o   I P   a d d r e s s   o r   H o s t n a m e ?��  ��  � ����
�� 
dtxt� m   z }�� ���  � �����
�� 
appr� n   � ���� 1   � ��
� 
pnam�  f   � ���  � o      �~�~ 0 b  � ��� r   � ���� n   � ���� 1   � ��}
�} 
ttxt� o   � ��|�| 0 b  � o      �{�{ 0 thehost theHost� ��z� I  � ��y��x
�y .sysoexecTEXT���     TEXT� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� 2 d e f a u l t s   w r i t e   c o m . c i s c o .� n   � ���� 1   � ��w
�w 
strq� o   � ��v�v 0 	prefsname 	prefsName� m   � ��� ���    h o s t n a m e� m   � ��� ���    '� o   � ��u�u 0 thehost theHost� m   � ��� ���  '�x  �z  7 "  no previous username entry    8 ��� 8   n o   p r e v i o u s   u s e r n a m e   e n t r y  ! ��� Q   ����� l  � ����� r   � ���� I  � ��t��s
�t .sysoexecTEXT���     TEXT� b   � ���� b   � ���� m   � ��� ��� 0 d e f a u l t s   r e a d   c o m . c i s c o .� n   � ���� 1   � ��r
�r 
strq� o   � ��q�q 0 	prefsname 	prefsName� m   � ��� ���    u s e r n a m e�s  � o      �p�p 0 theuser theUser� ; 5 check to see if a username has been previously saved   � ��� j   c h e c k   t o   s e e   i f   a   u s e r n a m e   h a s   b e e n   p r e v i o u s l y   s a v e d� R      �o�n�m
�o .ascrerr ****      � ****�n  �m  � l  ����� k   ��� ��� r   � ���� I  � ��l��
�l .sysodlogaskr        TEXT� l  � ���k�j� m   � ��� ��� < W h a t   i s   y o u r   D e s k p r o   U s e r n a m e ?�k  �j  � �i��
�i 
dtxt� m   � ��� ���  � �h��g
�h 
appr� n   � ���� 1   � ��f
�f 
pnam�  f   � ��g  � o      �e�e 0 b  � ��� r   � ���� n   � ���� 1   � ��d
�d 
ttxt� o   � ��c�c 0 b  � o      �b�b 0 theuser theUser� ��a� I  ��`��_
�` .sysoexecTEXT���     TEXT� b   �	��� b   �� � b   � b   � � b   � � m   � � � 2 d e f a u l t s   w r i t e   c o m . c i s c o . n   � �	
	 1   � ��^
�^ 
strq
 o   � ��]�] 0 	prefsname 	prefsName m   � � �    u s e r n a m e m   �  �    '  o  �\�\ 0 theuser theUser� m   �  '�_  �a  � "  no previous username entry    � � 8   n o   p r e v i o u s   u s e r n a m e   e n t r y  �  Q  � l ( r  ( I $�[�Z
�[ .sysoexecTEXT���     TEXT b    b    b  !"! m  ## �$$ F s e c u r i t y   f i n d - g e n e r i c - p a s s w o r d   - w l  " n  %&% 1  �Y
�Y 
strq& o  �X�X 0 	prefsname 	prefsName  m  '' �((  . o  �W�W 0 theuser theUser�Z   o      �V�V 0 mybase64url myBase64Url < 6 check to see if a base64url has been previously saved    �)) l   c h e c k   t o   s e e   i f   a   b a s e 6 4 u r l   h a s   b e e n   p r e v i o u s l y   s a v e d R      �U�T�S
�U .ascrerr ****      � ****�T  �S   l 0�*+,* k  0�-- ./. r  07010 m  0322 �33  1 o      �R�R 0 trypwd tryPWD/ 454 W  8{676 k  Bv88 9:9 r  B_;<; I B]�Q=>
�Q .sysodlogaskr        TEXT= l BE?�P�O? m  BE@@ �AA < W h a t   i s   y o u r   D e s k p r o   P a s s w o r d ?�P  �O  > �NBC
�N 
dtxtB m  HKDD �EE  C �MFG
�M 
apprF n  NSHIH 1  OS�L
�L 
pnamI  f  NOG �KJ�J
�K 
htxtJ m  VW�I
�I boovtrue�J  < o      �H�H 0 	passwordq  : KLK r  `iMNM n  `eOPO 1  ae�G
�G 
ttxtP o  `a�F�F 0 	passwordq  N o      �E�E 0 thepwd thePwdL Q�DQ l  jvRSTR r  jvUVU I  jr�CW�B�C 0 pwdok pwdOKW X�AX o  kn�@�@ 0 thepwd thePwd�A  �B  V o      �?�? 0 trypwd tryPWDS 9 3 Check the password entered for invalid characters    T �YY f   C h e c k   t h e   p a s s w o r d   e n t e r e d   f o r   i n v a l i d   c h a r a c t e r s  �D  7 = <AZ[Z o  <?�>�> 0 trypwd tryPWD[ m  ?@�=
�= boovtrue5 \]\ I |��<^_
�< .sysonotfnull��� ��� TEXT^ l |`�;�:` m  |aa �bb * C a l c u l a t i n g   b a s e 6 4 u r l�;  �:  _ �9c�8
�9 
apprc n  ��ded 1  ���7
�7 
pname  f  ���8  ] fgf r  ��hih I ���6j�5
�6 .sysoexecTEXT���     TEXTj b  ��klk b  ��mnm b  ��opo b  ��qrq m  ��ss �tt  p r i n t f  r o  ���4�4 0 theuser theUserp m  ��uu �vv  :n o  ���3�3 0 thepwd thePwdl m  ��ww �xx    |   b a s e 6 4�5  i o      �2�2 0 mybase64url myBase64Urlg y�1y I ���0z�/
�0 .sysoexecTEXT���     TEXTz b  ��{|{ b  ��}~} b  ��� b  ����� b  ����� b  ����� b  ����� m  ���� ��� B s e c u r i t y   a d d - g e n e r i c - p a s s w o r d   - a  � n  ����� 1  ���.
�. 
strq� o  ���-�- 0 	prefsname 	prefsName� m  ���� ��� 
     - w  � n  ����� 1  ���,
�, 
strq� o  ���+�+ 0 mybase64url myBase64Url� m  ���� ��� V   - j   ' U s e d   b y   A p p l e s c r i p t   D e s k p r o   V o l u m e '   - s� n  ����� 1  ���*
�* 
strq� o  ���)�) 0 	prefsname 	prefsName~ m  ���� ���  .| o  ���(�( 0 theuser theUser�/  �1  + * $ no previous base64url in keychain     , ��� H   n o   p r e v i o u s   b a s e 6 4 u r l   i n   k e y c h a i n     ��� Q  �^���� l ������ r  ����� I ���'��&
�' .sysoexecTEXT���     TEXT� b  ����� b  ����� m  ���� ��� 0 d e f a u l t s   r e a d   c o m . c i s c o .� n  ����� 1  ���%
�% 
strq� o  ���$�$ 0 	prefsname 	prefsName� m  ���� ��� 0   i g n o r e _ s e l f _ s i g n e d _ c e r t�&  � o      �#�# 0 selfcert  � < 6 check to see if ignore self_signed_cert has been set    � ��� l   c h e c k   t o   s e e   i f   i g n o r e   s e l f _ s i g n e d _ c e r t   h a s   b e e n   s e t  � R      �"�!� 
�" .ascrerr ****      � ****�!  �   � l �^���� k  �^�� ��� r  ���� I ����
� .sysodlogaskr        TEXT� l ������ b  ����� b  ����� b  ����� m  ���� ��� � D o   y o u   w a n t   t h e   s c r i p t   t o   i g n o r e   t h e   d e f a u l t   D e s k p r o   S e l f   S i g n e d   C e r t ?� o  ���
� 
ret � o  ���
� 
ret � m  ���� ��� n   S e t   t h i s   t o   n o   i f   y o u   h a v e   a   v a l i d   c e r t   o n   t h e   d e s k p r o�  �  � ���
� 
btns� J  ��� ��� m  ���� ���  Y e s� ��� m  � �� ���  N o�  � ���
� 
dflt� m  �� ���  Y e s� ���
� 
appr� n  ��� 1  �
� 
pnam�  f  �  � o      �� 0 b  � ��� Z  ^����� = "��� n  ��� 1  �
� 
bhit� o  �� 0 b  � m  !�� ���  Y e s� k  %@�� ��� r  %,��� m  %(�� ���  - k� o      �� 0 selfcert  � ��� I -@���
� .sysoexecTEXT���     TEXT� b  -<��� b  -8��� b  -4��� m  -0�� ��� 2 d e f a u l t s   w r i t e   c o m . c i s c o .� n  03��� 1  13�
� 
strq� o  01�
�
 0 	prefsname 	prefsName� m  47�� ��� 0   i g n o r e _ s e l f _ s i g n e d _ c e r t� m  8;�� ��� 
   ' - k '�  �  �  � k  C^�� ��� r  CJ��� m  CF�� ���  � o      �	�	 0 selfcert  � ��� I K^���
� .sysoexecTEXT���     TEXT� b  KZ��� b  KV   b  KR m  KN � 2 d e f a u l t s   w r i t e   c o m . c i s c o . n  NQ 1  OQ�
� 
strq o  NO�� 0 	prefsname 	prefsName m  RU �		 0   i g n o r e _ s e l f _ s i g n e d _ c e r t� m  VY

 �    ' '�  �  �  � i c no previous autoanswer entry to ignore the self signed cert we inject a -k into the curl commands    � � �   n o   p r e v i o u s   a u t o a n s w e r   e n t r y   t o   i g n o r e   t h e   s e l f   s i g n e d   c e r t   w e   i n j e c t   a   - k   i n t o   t h e   c u r l   c o m m a n d s  �  Q  _� l bu r  bu I bq��
� .sysoexecTEXT���     TEXT b  bm b  bi m  be � 0 d e f a u l t s   r e a d   c o m . c i s c o . n  eh 1  fh�
� 
strq o  ef� �  0 	prefsname 	prefsName m  il   �!!    A u t o A n s w e r�   o      ���� 0 
autoanswer 
AutoAnswer 0 * check to see if Auto Answer has been set     �"" T   c h e c k   t o   s e e   i f   A u t o   A n s w e r   h a s   b e e n   s e t   R      ������
�� .ascrerr ****      � ****��  ��   l }�#$%# k  }�&& '(' r  }�)*) I }���+,
�� .sysodlogaskr        TEXT+ l }�-����- m  }�.. �// v D o   y o u   w a n t   t h e   s c r i p t   t o   b e   a b l e   t o   a n s w e r   i n c o m i n g   c a l l s ?��  ��  , ��01
�� 
btns0 J  ��22 343 m  ��55 �66  Y e s4 7��7 m  ��88 �99  N o��  1 ��:;
�� 
dflt: m  ��<< �==  Y e s; ��>��
�� 
appr> n  ��?@? 1  ����
�� 
pnam@  f  ����  * o      ���� 0 b  ( ABA r  ��CDC 1  ����
�� 
rsltD o      ���� 0 
autoanswer 
AutoAnswerB E��E I ����F��
�� .sysoexecTEXT���     TEXTF b  ��GHG b  ��IJI b  ��KLK m  ��MM �NN 2 d e f a u l t s   w r i t e   c o m . c i s c o .L n  ��OPO 1  ����
�� 
strqP o  ������ 0 	prefsname 	prefsNameJ m  ��QQ �RR    A u t o A n s w e rH m  ��SS �TT    ' Y e s '��  ��  $ #  no previous autoanswer entry   % �UU :   n o   p r e v i o u s   a u t o a n s w e r   e n t r y VWV l ����������  ��  ��  W XYX Q  �Z[\Z l ��]^_] r  ��`a` I ����b��
�� .sysoexecTEXT���     TEXTb b  ��cdc b  ��efe m  ��gg �hh 0 d e f a u l t s   r e a d   c o m . c i s c o .f n  ��iji 1  ����
�� 
strqj o  ������ 0 	prefsname 	prefsNamed m  ��kk �ll    v o l u m e _ c a l l��  a o      ���� 0 thecallvolume theCallVolume^ > 8 check to see if a call volume has been previously saved   _ �mm p   c h e c k   t o   s e e   i f   a   c a l l   v o l u m e   h a s   b e e n   p r e v i o u s l y   s a v e d[ R      ������
�� .ascrerr ****      � ****��  ��  \ l �nopn k  �qq rsr r  ��tut I ����vw
�� .sysodlogaskr        TEXTv l ��x����x m  ��yy �zz \ W h a t   i s   y o u r   p r e f e r r e d   v o l u m e   w h i l e   i n   a   c a l l ?��  ��  w ��{|
�� 
dtxt{ m  ��}} �~~  5 5| ����
�� 
appr n  ����� 1  ����
�� 
pnam�  f  ����  u o      ���� 0 b  s ��� r  ����� n  ����� 1  ����
�� 
ttxt� o  ������ 0 b  � o      ���� 0 thecallvolume theCallVolume� ���� I  �����
�� .sysoexecTEXT���     TEXT� b   ��� b   ��� b   ��� b   ��� b   ��� m   �� ��� 2 d e f a u l t s   w r i t e   c o m . c i s c o .� n  ��� 1  ��
�� 
strq� o  ���� 0 	prefsname 	prefsName� m  
�� ���    v o l u m e _ c a l l� m  �� ���    '� o  ���� 0 thecallvolume theCallVolume� m  �� ���  '��  ��  o "  no previous username entry    p ��� 8   n o   p r e v i o u s   u s e r n a m e   e n t r y  Y ��� Q  y���� l 2���� r  2��� I .�����
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
strq� o  ������ 0 	prefsname 	prefsName� m  ���� ���    t p l i n k _ c o n t r o l��  ��  ��  � m  ���� ���  1� k  �)�� �	 � r  ��			 m  ��		 �		  1	 o      ���� 
0 tplink  	  	��	 Q  �)				 r  ��			
		 I ����	��
�� .sysoexecTEXT���     TEXT	 b  ��			 b  ��			 m  ��		 �		 0 d e f a u l t s   r e a d   c o m . c i s c o .	 n  ��			 1  ����
�� 
strq	 o  ������ 0 	prefsname 	prefsName	 m  ��		 �		    T P L i n k _ d e v i c e s��  	
 o      ���� "0 mytplinkdevices myTPLinkDevices	 R      ������
�� .ascrerr ****      � ****��  ��  	 k  �)		 			 r  ��			 m  ��		 �		  1	 o      ���� "0 newtplinkdevice newTPLinkDevice	 			 r  ��		 	 J  ������  	  o      ���� "0 mytplinkdevices myTPLinkDevices	 	!	"	! W  �	#	$	# k  �	%	% 	&	'	& r  ��	(	)	( I ����	*	+
�� .sysodlogaskr        TEXT	* m  ��	,	, �	-	- 8 E n t e r   y o u r   T P - L i n k   d e v i c e   I d	+ ��	.	/
�� 
dtxt	. m  ��	0	0 �	1	1  	/ ��	2��
�� 
appr	2 n  ��	3	4	3 1  ����
�� 
pnam	4  f  ����  	) o      ���� "0 newtplinkdevice newTPLinkDevice	' 	5	6	5 r  ��	7	8	7 n  ��	9	:	9 1  ����
�� 
ttxt	: o  ������ "0 newtplinkdevice newTPLinkDevice	8 o      ���� "0 newtplinkdevice newTPLinkDevice	6 	;��	; Z  �	<	=����	< > ��	>	?	> o  ������ "0 newtplinkdevice newTPLinkDevice	? m  ��	@	@ �	A	A  	= r  �	B	C	B b  ��	D	E	D o  ������ "0 newtplinkdevice newTPLinkDevice	E m  ��	F	F �	G	G  \ r	C l     	H����	H n      	I	J	I  ;  	J o  ����� "0 mytplinkdevices myTPLinkDevices��  ��  ��  ��  ��  	$ = ��	K	L	K o  ������ "0 newtplinkdevice newTPLinkDevice	L m  ��	M	M �	N	N  	" 	O��	O I )��	P��
�� .sysoexecTEXT���     TEXT	P b  %	Q	R	Q b  !	S	T	S b  	U	V	U b  	W	X	W b  	Y	Z	Y m  	[	[ �	\	\ 2 d e f a u l t s   w r i t e   c o m . c i s c o .	Z n  	]	^	] 1  ��
�� 
strq	^ o  ���� 0 	prefsname 	prefsName	X m  	_	_ �	`	`    T P L i n k _ d e v i c e s	V m  	a	a �	b	b    '	T o   ���� "0 mytplinkdevices myTPLinkDevices	R m  !$	c	c �	d	d  '��  ��  ��  ��  � r  ,3	e	f	e m  ,/	g	g �	h	h  0	f o      ���� 
0 tplink  � R      ������
�� .ascrerr ****      � ****��  ��  � k  ;�	i	i 	j	k	j r  ;_	l	m	l I ;]��	n	o
�� .sysodlogaskr        TEXT	n l ;>	p����	p m  ;>	q	q �	r	r t D o   y o u   w a n t   t h e   s c r i p t   t o   c o n t r o l   a n   I n - C a l l   S t a t u s   L i g h t ?��  ��  	o ��	s	t
�� 
btns	s J  AI	u	u 	v	w	v m  AD	x	x �	y	y  Y e s	w 	z��	z m  DG	{	{ �	|	|  N o��  	t ��	}	~
�� 
dflt	} m  LO		 �	�	�  Y e s	~ �	��~
� 
appr	� n  RW	�	�	� 1  SW�}
�} 
pnam	�  f  RS�~  	m o      �|�| 0 c  	k 	�	�	� Z  `�	�	��{	�	� = `i	�	�	� n  `e	�	�	� 1  ae�z
�z 
bhit	� o  `a�y�y 0 c  	� m  eh	�	� �	�	�  Y e s	� k  l�	�	� 	�	�	� I l�x	��w
�x .sysoexecTEXT���     TEXT	� b  l{	�	�	� b  lw	�	�	� b  ls	�	�	� m  lo	�	� �	�	� 2 d e f a u l t s   w r i t e   c o m . c i s c o .	� n  or	�	�	� 1  pr�v
�v 
strq	� o  op�u�u 0 	prefsname 	prefsName	� m  sv	�	� �	�	�    t p l i n k _ c o n t r o l	� m  wz	�	� �	�	�    ' 1 '�w  	� 	��t	� r  ��	�	�	� m  ��	�	� �	�	�  1	� o      �s�s 
0 tplink  �t  �{  	� k  ��	�	� 	�	�	� I ���r	��q
�r .sysoexecTEXT���     TEXT	� b  ��	�	�	� b  ��	�	�	� b  ��	�	�	� m  ��	�	� �	�	� 2 d e f a u l t s   w r i t e   c o m . c i s c o .	� n  ��	�	�	� 1  ���p
�p 
strq	� o  ���o�o 0 	prefsname 	prefsName	� m  ��	�	� �	�	�    t p l i n k _ c o n t r o l	� m  ��	�	� �	�	�    ' 0 '�q  	� 	��n	� r  ��	�	�	� m  ��	�	� �	�	�  0	� o      �m�m 
0 tplink  �n  	� 	��l	� I  ���k	��j�k 0 get_prereqs get_PreReqs	� 	��i	� m  ��	�	� �	�	�  g e t P r e f s�i  �j  �l  � 	��h	� l ���g�f�e�g  �f  �e  �h  ��  ��   	��d	� L  ���c�c  �d   	�	�	� l     �b�a�`�b  �a  �`  	� 	�	�	� i   7 :	�	�	� I      �_�^�]�_ 0 post_cmd  �^  �]  	� k    	�	� 	�	�	� r     	�	�	� J     �\�\  	� o      �[�[ 0 
mycmdstart 
myCmdStart	� 	�	�	� r    		�	�	� J    �Z�Z  	� o      �Y�Y 0 mycmdend myCmdEnd	� 	�	�	� r   
 	�	�	� n   
 	�	�	� 2   �X
�X 
cobj	� o   
 �W�W 0 mycmd myCmd	� o      �V�V 0 newcmd newCmd	� 	�	�	� X    N	��U	�	� Z     I	�	��T�S	� >    #	�	�	� o     !�R�R 0 
newelement 
newElement	� m   ! "	�	� �	�	�  	� k   & E	�	� 	�	�	� r   & .	�	�	� b   & +	�	�	� b   & )	�	�	� m   & '	�	� �	�	�  <	� o   ' (�Q�Q 0 
newelement 
newElement	� m   ) *	�	� �	�	�  >	� l     	��P�O	� n      	�	�	�  ;   , -	� o   + ,�N�N 0 
mycmdstart 
myCmdStart�P  �O  	� 	�	�	� Z   / <	�	��M�L	� E   / 2	�	�	� o   / 0�K�K 0 
newelement 
newElement	� m   0 1	�	� �	�	� $ S e t   c o m m a n d = " T r u e "	� r   5 8	�	�	� m   5 6	�	� �	�	�  S e t	� o      �J�J 0 
newelement 
newElement�M  �L  	� 	��I	� r   = E
 

  b   = B


 b   = @


 m   = >

 �

  < /
 o   > ?�H�H 0 
newelement 
newElement
 m   @ A

 �
	
	  >
 l     

�G�F

 n      


  :   C D
 o   B C�E�E 0 mycmdend myCmdEnd�G  �F  �I  �T  �S  �U 0 
newelement 
newElement	� o    �D�D 0 newcmd newCmd	� 


 r   O p


 b   O l


 b   O h


 b   O f


 b   O b


 b   O `


 b   O \


 b   O X


 b   O T

 
 b   O R
!
"
! o   O P�C�C 0 selfcert  
" m   P Q
#
# �
$
$ H   - - l o c a t i o n   - - r e q u e s t   P O S T   " h t t p s : / /
  o   R S�B�B 0 thehost theHost
 m   T W
%
% �
&
& P / p u t x m l "   - - h e a d e r   ' A u t h o r i z a t i o n :   B a s i c  
 o   X [�A�A 0 mybase64url myBase64Url
 m   \ _
'
' �
(
( d '   - - h e a d e r   ' C o n t e n t - T y p e :   t e x t / p l a i n '   - - d a t a - r a w   '
 o   ` a�@�@ 0 
mycmdstart 
myCmdStart
 o   b e�?�? 0 thevar theVar
 o   f g�>�> 0 mycmdend myCmdEnd
 m   h k
)
) �
*
*  '    
 o      �=�= 0 postcmd postCmd
 
+
,
+ l  q q�<�;�:�<  �;  �:  
, 
-
.
- Z   q
/
0�9�8
/ >  q w
1
2
1 o   q t�7�7 0 my2ndcmd my2ndCmd
2 J   t v�6�6  
0 k   z
3
3 
4
5
4 r   z ~
6
7
6 J   z |�5�5  
7 o      �4�4 0 my2ndcmdstart my2ndCmdStart
5 
8
9
8 r    �
:
;
: J    ��3�3  
; o      �2�2 0 my2ndcmdend my2ndCmdEnd
9 
<
=
< r   � �
>
?
> n   � �
@
A
@ 2  � ��1
�1 
cobj
A o   � ��0�0 0 my2ndcmd my2ndCmd
? o      �/�/ 0 	new2ndcmd 	new2ndCmd
= 
B
C
B X   � �
D�.
E
D Z   � �
F
G�-�,
F >  � �
H
I
H o   � ��+�+ 0 new2ndelement new2ndElement
I m   � �
J
J �
K
K  
G k   � �
L
L 
M
N
M r   � �
O
P
O b   � �
Q
R
Q b   � �
S
T
S m   � �
U
U �
V
V  <
T o   � ��*�* 0 new2ndelement new2ndElement
R m   � �
W
W �
X
X  >
P l     
Y�)�(
Y n      
Z
[
Z  ;   � �
[ o   � ��'�' 0 my2ndcmdstart my2ndCmdStart�)  �(  
N 
\
]
\ Z   � �
^
_�&�%
^ E   � �
`
a
` o   � ��$�$ 0 new2ndelement new2ndElement
a m   � �
b
b �
c
c $ S e t   c o m m a n d = " T r u e "
_ r   � �
d
e
d m   � �
f
f �
g
g  S e t
e o      �#�# 0 new2ndelement new2ndElement�&  �%  
] 
h�"
h r   � �
i
j
i b   � �
k
l
k b   � �
m
n
m m   � �
o
o �
p
p  < /
n o   � ��!�! 0 new2ndelement new2ndElement
l m   � �
q
q �
r
r  >
j l     
s� �
s n      
t
u
t  :   � �
u o   � ��� 0 my2ndcmdend my2ndCmdEnd�   �  �"  �-  �,  �. 0 new2ndelement new2ndElement
E o   � ��� 0 	new2ndcmd 	new2ndCmd
C 
v�
v r   �
w
x
w b   � 
y
z
y b   � �
{
|
{ b   � �
}
~
} b   � �

�
 b   � �
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
� o   � ��� 0 postcmd postCmd
� m   � �
�
� �
�
�    - :  
� o   � ��� 0 selfcert  
� m   � �
�
� �
�
� J     - - l o c a t i o n   - - r e q u e s t   P O S T   " h t t p s : / /
� o   � ��� 0 thehost theHost
� m   � �
�
� �
�
� P / p u t x m l "   - - h e a d e r   ' A u t h o r i z a t i o n :   B a s i c  
� o   � ��� 0 mybase64url myBase64Url
� m   � �
�
� �
�
� d '   - - h e a d e r   ' C o n t e n t - T y p e :   t e x t / p l a i n '   - - d a t a - r a w   '
� o   � ��� 0 my2ndcmdstart my2ndCmdStart
~ o   � ��� 0 	the2ndvar 	the2ndVar
| o   � ��� 0 my2ndcmdend my2ndCmdEnd
z m   � �
�
� �
�
�  '
x o      �� 0 postcmd postCmd�  �9  �8  
. 
��
� l  	
�
�
�
� I 	�
��
� .sysoexecTEXT���     TEXT
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
� o  �� 0 postcmd postCmd
� m  
�
� �
�
�    & >   / d e v / n u l l  �  
� &   Send the command to the device    
� �
�
� @   S e n d   t h e   c o m m a n d   t o   t h e   d e v i c e  �  	� 
�
�
� l     ����  �  �  
� 
�
�
� i   ; >
�
�
� I      ���
� 0 get_xml  �  �
  
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
� o      �	�	 0 grep_for  
� 
�
�
� r    
�
�
� n    
�
�
� 2   �
� 
cpar
� l   
���
� I   �
��
� .sysoexecTEXT���     TEXT
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
� o    �� 0 thehost theHost
� m    
�
� �
�
� r / g e t x m l ? l o c a t i o n = / S t a t u s "   - - h e a d e r   ' A u t h o r i z a t i o n :   B a s i c  
� o   	 
�� 0 mybase64url myBase64Url
� m    
�
� �
�
�  '       |   g r e p  
� o    �� 0 grep_for  �  �  �  
� o      � �  $0 thestatusresults theStatusResults
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
� r   S b
�
�
� n   S \
�
�
� 4   Y \��
�
�� 
cwor
� m   Z [���� 
� n   S Y   4   T Y��
�� 
cobj m   U X����  o   S T���� $0 thestatusresults theStatusResults
� o      ���� 0 callduration callDuration
� �� r   c r n   c l 4   i l��
�� 
cwor m   j k����  n   c i	
	 4   d i��
�� 
cobj m   e h���� 
 o   c d���� $0 thestatusresults theStatusResults o      ���� 0 
callstatus 
callStatus��  
� R      ������
�� .ascrerr ****      � ****��  ��  ��  
� �� l  | |����  <6	display dialog "Deskpro Call States" & return & "Call Status: " & callStatus & return & "Call Duration: " & callDuration & return & "Answered State: " & answeredState & return & return & "Deskpro Volume States" & return & "Current Volume is: " & theCurrVolume & return & "The Mic Mute State is: " & muteStatus    �l 	 d i s p l a y   d i a l o g   " D e s k p r o   C a l l   S t a t e s "   &   r e t u r n   &   " C a l l   S t a t u s :   "   &   c a l l S t a t u s   &   r e t u r n   &   " C a l l   D u r a t i o n :   "   &   c a l l D u r a t i o n   &   r e t u r n   &   " A n s w e r e d   S t a t e :   "   &   a n s w e r e d S t a t e   &   r e t u r n   &   r e t u r n   &   " D e s k p r o   V o l u m e   S t a t e s "   &   r e t u r n   &   " C u r r e n t   V o l u m e   i s :   "   &   t h e C u r r V o l u m e   &   r e t u r n   &   " T h e   M i c   M u t e   S t a t e   i s :   "   &   m u t e S t a t u s��  
�  l     ��������  ��  ��    l      ����   B < CONTROL TP-LINK SMART OUTLET as "In Call" status indicator     � x   C O N T R O L   T P - L I N K   S M A R T   O U T L E T   a s   " I n   C a l l "   s t a t u s   i n d i c a t o r    i   ? B I      ������ 0 
set_tplink   �� o      ���� 	0 state  ��  ��   Z     <���� =      o     ���� 
0 tplink    m    !! �""  1 Q    8#$��# X   	 /%��&% k    *'' ()( l   *+,* r    -.- o    ���� 0 
mydeviceid 
myDeviceid. o      ���� 0 
mydeviceid 
myDeviceid+   of myTPLinkDevices   , �// &   o f   m y T P L i n k D e v i c e s) 0��0 I   *��1��
�� .sysoexecTEXT���     TEXT1 b    &232 b    $454 b    "676 m     88 �99 6 / u s r / l o c a l / b i n / k a s a   - - h o s t  7 o     !���� 0 
mydeviceid 
myDeviceid5 m   " #:: �;;   3 o   $ %���� 	0 state  ��  ��  �� 0 
mydeviceid 
myDeviceid& n    <=< 2   ��
�� 
cwor= o    ���� "0 mytplinkdevices myTPLinkDevices$ R      ������
�� .ascrerr ****      � ****��  ��  ��  ��  ��   >?> l     ��������  ��  ��  ? @A@ l     ��BC��  B ^ X Verify that a thePwd does not contain any characters that will break the base64 command   C �DD �   V e r i f y   t h a t   a   t h e P w d   d o e s   n o t   c o n t a i n   a n y   c h a r a c t e r s   t h a t   w i l l   b r e a k   t h e   b a s e 6 4   c o m m a n dA EFE i   C FGHG I      ��I���� 0 pwdok pwdOKI J��J o      ���� 0 thepwd thePwd��  ��  H k     *KK LML r     NON n     PQP 2   ��
�� 
cha Q o     ���� 0 thepwd thePwdO o      ���� 0 pwdchars PWDcharsM RSR X    'T��UT Z    "VW����V E   XYX o    ���� 0 badpwdchars BadPWDcharsY o    ���� 0 ch  W L    ZZ m    ��
�� boovfals��  ��  �� 0 ch  U o   	 
���� 0 pwdchars PWDcharsS [��[ L   ( *\\ m   ( )��
�� boovtrue��  F ]^] l     ��������  ��  ��  ^ _`_ i   G Jaba I      ��c���� ,0 removemarkupfromtext removeMarkupFromTextc d��d o      ���� 0 thetext theText��  ��  b k     ]ee fgf r     hih m     ��
�� boovfalsi o      ���� 0 tagdetected tagDetectedg jkj r    lml m    nn �oo  m o      ���� 0 thecleantext theCleanTextk pqp Y    Vr��st��r k    Quu vwv r    xyx n    z{z 4    ��|
�� 
cha | o    ���� 0 a  { o    ���� 0 thetext theTexty o      ���� *0 thecurrentcharacter theCurrentCharacterw }��} Z     Q~���~ =    #��� o     !���� *0 thecurrentcharacter theCurrentCharacter� m   ! "�� ���  < r   & )��� m   & '��
�� boovtrue� o      ���� 0 tagdetected tagDetected� ��� =  , /��� o   , -���� *0 thecurrentcharacter theCurrentCharacter� m   - .�� ���  >� ��� r   2 5��� m   2 3��
�� boovfals� o      ���� 0 tagdetected tagDetected� ��� =  8 ;��� o   8 9���� 0 tagdetected tagDetected� m   9 :��
�� boovfals� ���� r   > M��� c   > G��� b   > E��� o   > C���� 0 thecleantext theCleanText� o   C D���� *0 thecurrentcharacter theCurrentCharacter� m   E F��
�� 
TEXT� o      ���� 0 thecleantext theCleanText��  ��  ��  �� 0 a  s m    ���� t n    ��� 1    ��
�� 
leng� o    ���� 0 thetext theText��  q ���� L   W ]�� o   W \���� 0 thecleantext theCleanText��  ` ��� l     ��������  ��  ��  � ��� l      ������  � L F USED FOR TESTING TOTAL TIME TO EXECUTE THE SCRIPT TO THE MILLISECOND    � ��� �   U S E D   F O R   T E S T I N G   T O T A L   T I M E   T O   E X E C U T E   T H E   S C R I P T   T O   T H E   M I L L I S E C O N D  � ��� l     ����  � . (set mgStop to do shell script mgRightNow   � ��� P s e t   m g S t o p   t o   d o   s h e l l   s c r i p t   m g R i g h t N o w� ��� l     �~���~  � ' !set mgRunTime to mgStop - mgStart   � ��� B s e t   m g R u n T i m e   t o   m g S t o p   -   m g S t a r t� ��� l     �}���}  � � zdisplay dialog "This took " & mgRunTime & " seconds." & return & "that's " & (round (mgRunTime * 1000)) & " milliseconds."   � ��� � d i s p l a y   d i a l o g   " T h i s   t o o k   "   &   m g R u n T i m e   &   "   s e c o n d s . "   &   r e t u r n   &   " t h a t ' s   "   &   ( r o u n d   ( m g R u n T i m e   *   1 0 0 0 ) )   &   "   m i l l i s e c o n d s . "� ��� l     �|�{�z�|  �{  �z  � ��y� l     �x�w�v�x  �w  �v  �y       �u�� � � � � � � � ����������u  � �t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d
�t 
pimr�s 0 
mutestatus 
muteStatus�r 0 thecurrvolume theCurrVolume�q 0 answeredstate answeredState�p 0 callduration callDuration�o 0 	thevolume 	theVolume�n 0 
callstatus 
callStatus�m 0 
thevolmute 
theVolMute�l 0 thecleantext theCleanText�k 0 
get_volume 
get_Volume�j 0 get_prereqs get_PreReqs�i 0 post_cmd  �h 0 get_xml  �g 0 
set_tplink  �f 0 pwdok pwdOK�e ,0 removemarkupfromtext removeMarkupFromText
�d .aevtoappnull  �   � ****� �c��c �  ��� �b �a
�b 
vers�a  � �`��_
�` 
cobj� ��   �^
�^ 
osax�_  � �]��\�[���Z�] 0 
get_volume 
get_Volume�\  �[  � �Y�Y 0 b  � �� �X�W�V�U�T�S!�R%�Q�P�O�N�M�L3:>AE�KV�J�I`l�H�G�Fw���E�������D�C���B�������	")6=ADHV]jqux|�������������A������	!%(�@3?CGJUaeilw�����������������������X 0 
set_tplink  �W 0 get_xml  �V  �U  �T 0 thecallvolume theCallVolume
�S 
btns
�R 
dflt
�Q 
givu�P 
�O 
appr
�N 
pnam�M 
�L .sysodlogaskr        TEXT
�K 
bhit�J 0 themacvolume theMacVolume�I 0 thevar theVar�H 0 themutevolume theMuteVolume
�G 
errn�F���E 0 	the2ndvar 	the2ndVar�D 0 mycmd myCmd�C 0 post_cmd  
�B 
bool�A �@ 0 my2ndcmd my2ndCmd�Z`b  �  �*�k+ O 
*j+ W 	X  hOb  �  �����mv����a )a ,a  E�Y 'a �a a a mv�a ��a )a ,a  E�O�a ,a   _ E` Y 6�a ,a   
�E` Y "�a ,a   _ E` Y )a  a !lhY�b  a " y*a #k+ O[a $E` Oa %E` &Ob  a ' &�E` Oa (a )a *a +a ,�vE` -O*j+ .Y hOb  a / 	 b  a 0 a 1& *a 2�a 3a 4a 5mv�a 6��a )a ,a  E�Y=b  a 7 	 b  a 8 	 b  �a 1&a 1& *a 9�a :a ;a <mv�a =��a )a ,a  E�Y �b  a > 	 b  a ? 	 b  �a 1&a 1& *a @�a Aa Ba Cmv�a D��a )a ,a  E�Y �b  a E 	 b  a F 	 b  �a 1&a 1& *a G�a Ha Ia Jmv�a K��a )a ,a  E�Y Gb  a L 	 b  a M a 1& *a N�a Oa Pa Qmv�a R��a )a ,a  E�Y hO�a ,a S  "a Ta Ua Va Wa XvE` -O*j+ .OhYj�a ,a Y  "a Za [a \a ]a XvE` -O*j+ .OhY>�a ,a ^  7a _a `a aa ba XvE` -Oa ca da ea fa XvE` gO*j+ .OhY ��a ,a h  "a ia ja ka la XvE` -O*j+ .OhY Ѡa ,a m  "a na oa pa qa XvE` -O*j+ .OhY ��a ,a r  7a sa ta ua va XvE` -Oa wa xa ya za XvE` gO*j+ .OhY d�a ,a {  Na |a }a ~mvE` -Oa a �a �a �a ��vE` gO_ E` &O*j+ .O*a �k+ Oa �Ec  OhY )a  a !lhW X  )a  a !lhY hOa �a �a �a �a ��vE` -O*j+ .� �?�>�=���<�? 0 get_prereqs get_PreReqs�> �;��; �  �:�: 
0 action  �=  � �9�8�7�6�5�9 
0 action  �8 0 b  �7 0 	passwordq  �6 "0 newtplinkdevice newTPLinkDevice�5 0 c  � �/�4�33�2�1�0�/x�.{~�����������-�,�+��*��)�(�������'��#'�&2�%@D�$�#�"�!a� suw���������������������
 �.58<�MQSgk�y}����������������	�		�		M	,	0	@	F	[	_	a	c	g	q	x	{		�	�	�	�	�	�	�	�	�	���4 0 	prefsname 	prefsName
�3 
strq
�2 .sysoexecTEXT���     TEXT�1 0 thehost theHost�0  �/  
�. 
ret 
�- 
appr
�, 
pnam
�+ .sysodlogaskr        TEXT
�* 
dtxt�) 
�( 
ttxt�' 0 theuser theUser�& 0 mybase64url myBase64Url�% 0 trypwd tryPWD
�$ 
htxt�# �" 0 thepwd thePwd�! 0 pwdok pwdOK
�  .sysonotfnull��� ��� TEXT� 0 selfcert  
� 
btns
� 
dflt
� 
bhit� 0 
autoanswer 
AutoAnswer
� 
rslt� 0 thecallvolume theCallVolume� 0 themacvolume theMacVolume� 
0 tplink  � "0 mytplinkdevices myTPLinkDevices� 0 get_prereqs get_PreReqs�<��� � ���,%�%j E�W �X  ��%�%�%�%�%�%�%�%�%�%�%�%a %�%�%a %�%�%a %�%a %�%a %�%�%a %�%�%a %a )a ,l Oa a a a )a ,a  E�O�a ,E�Oa ��,%a  %a !%�%a "%j O a #��,%a $%j E` %W FX  a &a a 'a )a ,a  E�O�a ,E` %Oa (��,%a )%a *%_ %%a +%j O a ,��,%a -%_ %%j E` .W �X  a /E` 0O Bh_ 0e a 1a a 2a )a ,a 3ea 4 E�O�a ,E` 5O*_ 5k+ 6E` 0[OY��Oa 7a )a ,l 8Oa 9_ %%a :%_ 5%a ;%j E` .Oa <��,%a =%_ .�,%a >%��,%a ?%_ %%j O a @��,%a A%j E` BW yX  a C�%�%a D%a Ea Fa Glva Ha Ia )a ,a 4 E�O�a J,a K   a LE` BOa M��,%a N%a O%j Y a PE` BOa Q��,%a R%a S%j O a T��,%a U%j E` VW GX  a Wa Ea Xa Ylva Ha Za )a ,a 4 E�O_ [E` VOa \��,%a ]%a ^%j O a _��,%a `%j E` aW FX  a ba a ca )a ,a  E�O�a ,E` aOa d��,%a e%a f%_ a%a g%j O a h��,%a i%j E` jW FX  a ka a la )a ,a  E�O�a ,E` jOa m��,%a n%a o%_ j%a p%j O �a q��,%a r%j a s  �a tE` uO a v��,%a w%j E` xW wX  a yE�OjvE` xO Fh�a z a {a a |a )a ,a  E�O�a ,E�O�a } �a ~%_ x6FY h[OY��Oa ��,%a �%a �%_ x%a �%j Y 	a �E` uW zX  a �a Ea �a �lva Ha �a )a ,a 4 E�O�a J,a �   a ���,%a �%a �%j Oa �E` uY a ���,%a �%a �%j Oa �E` uO*a �k+ �OPY hOh� �	������� 0 post_cmd  �  �  � ������� 0 newcmd newCmd� 0 
newelement 
newElement� 0 my2ndcmdstart my2ndCmdStart� 0 my2ndcmdend my2ndCmdEnd� 0 	new2ndcmd 	new2ndCmd� 0 new2ndelement new2ndElement� '�
�	����	�	�	�	�	�

�
#�
%�
'�
)� ��
J
U
W
b
f
o
q
�
�
�
���
�
�
����
 0 
mycmdstart 
myCmdStart�	 0 mycmdend myCmdEnd� 0 mycmd myCmd
� 
cobj
� 
kocl
� .corecnte****       ****� 0 selfcert  � 0 thehost theHost� 0 mybase64url myBase64Url� 0 thevar theVar�  0 postcmd postCmd�� 0 my2ndcmd my2ndCmd�� 0 	the2ndvar 	the2ndVar
�� .sysoexecTEXT���     TEXT�jvE�OjvE�O��-E�O =�[��l kh �� $�%�%�6FO�� �E�Y hO�%�%�5FY h[OY��O��%�%a %_ %a %�%_ %�%a %E` O_ jv �jvE�OjvE�O_ �-E�O K�[��l kh �a  0a �%a %�6FO�a  
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
�� �� �� �� ��  ��  �� ~�E�O��%�%�%�%�%j �-E�O \���/��/Ec  O���/��/Ec  O���/��/Ec  O���/��/Ec  O��a /��/Ec  O��a /��/Ec  W X  hOP� ������������ 0 
set_tplink  �� ����� �  ���� 	0 state  ��  � ������ 	0 state  �� 0 
mydeviceid 
myDeviceid� ��!����������8:�������� 
0 tplink  �� "0 mytplinkdevices myTPLinkDevices
�� 
cwor
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� .sysoexecTEXT���     TEXT��  ��  �� =��  7 + %��-[��l kh �E�O�%�%�%j 	[OY��W X 
 hY h� ��H���������� 0 pwdok pwdOK�� ����� �  ���� 0 thepwd thePwd��  � �������� 0 thepwd thePwd�� 0 pwdchars PWDchars�� 0 ch  � ����������
�� 
cha 
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 0 badpwdchars BadPWDchars�� +��-E�O  �[��l kh Ģ fY h[OY��Oe� ��b���������� ,0 removemarkupfromtext removeMarkupFromText�� ����� �  ���� 0 thetext theText��  � ���������� 0 thetext theText�� 0 tagdetected tagDetected�� 0 a  �� *0 thecurrentcharacter theCurrentCharacter� n��������
�� 
leng
�� 
cha 
�� 
TEXT�� ^fE�O�Ec  O Ik��,Ekh ��/E�O��  eE�Y '��  fE�Y �f  b  �%�&Ec  Y h[OY��Ob  � �����������
�� .aevtoappnull  �   � ****� k    ���  O��  V��  ]��  k��  r�� (�� A�� M�� V�� ���  ����  ��  ��  �  � k T�� [�� b�� p�� y����048<?����������]fjt�����������������������������������������������������������!����+1��:>A��JNRVY��dh��q~����������������������������� 0 themacvolume theMacVolume�� 0 thecallvolume theCallVolume�� 0 themutevolume theMuteVolume�� 0 	prefsname 	prefsName
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
 _ ca ga R& a hEc  Y a iEc  W X \ ]a jEc  Y hO*j+ _Y hascr  ��ޭ