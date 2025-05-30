with Sf;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;
with Sf.Graphics.RenderWindow;

with SystemRecordsKonstantenHTSEB;
with UmwandlungssystemHTSEB;
with DateisystemtestsHTSEB;
with BetriebssystemKonstantenHTSEB;

with VerzeichnisKonstanten;

with SchreibeLogiktask;
with LeseLogiktask;
with SchreibeGrafiktask;
with LeseGrafiktask;

with FensterGrafik;

package body TexteingabeGrafik is

   procedure Texteingabe
   is
      use type Sf.sfBool;
      use type Sf.Window.Keyboard.sfKeyCode;
      use type Sf.Window.Mouse.sfMouseButton;
   begin
      
      TextSchleife:
      while
        Sf.sfTrue = Sf.Graphics.RenderWindow.pollEvent (renderWindow => FensterGrafik.FensterLesen,
                                                        event        => TextEingegeben)
      loop
         
         case
           TextEingegeben.eventType
         is
            when Sf.Window.Event.sfEvtTextEntered =>
               EingegebenesZeichen := Wide_Wide_Character'Val (TextEingegeben.text.unicode);
               
               if
                 EingegebenesZeichen = BetriebssystemKonstantenHTSEB.CR
               then
                  null;
               
               elsif
                 EingegebenesZeichen = BetriebssystemKonstantenHTSEB.BS
                 or
                   EingegebenesZeichen = BetriebssystemKonstantenHTSEB.DEL
               then
                  ZeichenEntfernen;
         
               else
                  ZeichenHinzufügen (EingegebenesZeichenExtern => EingegebenesZeichen);
               end if;
               
            when Sf.Window.Event.sfEvtKeyPressed =>
               if
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEnter
               then
                  case
                    LeseGrafiktask.Spielstandname
                  is
                     when False =>
                        TextGeprüft.ErfolgreichAbbruch := True;
                        TextGeprüft.EingegebenerText := LeseLogiktask.Texteingabe;
                        
                     when True =>
                        TextGeprüft := DateisystemtestsHTSEB.Namensprüfungen (TextExtern => LeseLogiktask.Texteingabe);
                  end case;
                  
                  case
                    TextGeprüft.ErfolgreichAbbruch
                  is
                     when True =>
                        SchreibeLogiktask.Texteingabe (TextExtern => TextGeprüft.EingegebenerText);
                        
                        SchreibeLogiktask.ErfolgTexteingabe (ErfolgExtern => True);
                        SchreibeGrafiktask.Texteingabe (JaNeinExtern => False);
                        SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
                        
                     when False =>
                        null;
                  end case;
                     
               elsif
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEscape
               then
                  Abbruch;
                  
               else
                  null;
               end if;
               
            when Sf.Window.Event.sfEvtMouseButtonPressed =>
               if
                 TextEingegeben.mouseButton.button = Sf.Window.Mouse.sfMouseRight
               then
                  Abbruch;
                  
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop TextSchleife;
      
   end Texteingabe;
   
   
   
   procedure Abbruch
   is begin
      
      SchreibeLogiktask.KompletteTexteingabe (EingabeExtern => SystemRecordsKonstantenHTSEB.LeerTexteingabe);
      SchreibeGrafiktask.Texteingabe (JaNeinExtern => False);
      SchreibeLogiktask.WartenGrafik (ZustandExtern => False);
      
   end Abbruch;
   
   
   
   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
   is begin
      
      case
        LeseGrafiktask.Spielstandname
      is
         when True =>
            if
              Spielstandnamen (EingegebenesZeichenExtern => EingegebenesZeichenExtern) = False
            then
               return;
                 
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
      
      SchreibeLogiktask.Texteingabe (TextExtern => (LeseLogiktask.Texteingabe & EingegebenesZeichenExtern));
      
   end ZeichenHinzufügen;
   
   
   
   -- Für den Fall dass das mal verschoben/verallgemeintert werden soll immer beachten dass das so nur die korrekten Abzugswerte für das Speichern übergibt!
   function Spielstandnamen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean
   is begin
      
      -- Hier mal die Textlänge anzeigen lassen um herauszufinden warum das nicht funktioneirt.
      
      case
        DateisystemtestsHTSEB.GültigeZeichenlänge (LinuxTextExtern   => LeseLogiktask.Texteingabe & EingegebenesZeichenExtern,
                                                          WindowsTextExtern =>
                                                             UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.VerzeichnisSpielstand) & LeseLogiktask.Texteingabe & EingegebenesZeichenExtern)
      is
         when False =>
            return False;
            
         when True =>
            return DateisystemtestsHTSEB.GültigesZeichen (ZeichenExtern => EingegebenesZeichenExtern);
      end case;
            
   end Spielstandnamen;
   
   
   
   procedure ZeichenEntfernen
   is begin
      
      Text := LeseLogiktask.Texteingabe;
      
      case
        To_Wide_Wide_String (Source => Text)'Length
      is
         when 0 =>
            null;
         
         when others =>
            SchreibeLogiktask.Texteingabe (TextExtern => Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => Text,
                                                                                                 From    => To_Wide_Wide_String (Source => Text)'Last,
                                                                                                 Through => To_Wide_Wide_String (Source => Text)'Last));
      end case;
      
   end ZeichenEntfernen;

end TexteingabeGrafik;
