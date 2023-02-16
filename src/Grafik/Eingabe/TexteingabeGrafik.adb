with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with Sf;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;
with Sf.Graphics.RenderWindow;

with SystemRecordKonstanten;
with SystemKonstanten;

with NachGrafiktask;
with NachLogiktask;
with SpielstandlisteLogik;
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
                 EingegebenesZeichen = CR
               then
                  null;
               
               elsif
                 EingegebenesZeichen = BS
                 or
                   EingegebenesZeichen = DEL
               then
                  ZeichenEntfernen;
         
               else
                  ZeichenHinzufügen (EingegebenesZeichenExtern => EingegebenesZeichen);
               end if;
               
            when Sf.Window.Event.sfEvtKeyPressed =>
               if
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEnter
               then
                  NachLogiktask.EingegebenerText.ErfolgreichAbbruch := True;
                  NachGrafiktask.TextEingabe := False;
                  NachLogiktask.Warten := False;
                     
               elsif
                 TextEingegeben.key.code = Sf.Window.Keyboard.sfKeyEscape
               then
                  NachLogiktask.EingegebenerText := SystemRecordKonstanten.LeerTexteingabe;
                  NachGrafiktask.TextEingabe := False;
                  NachLogiktask.Warten := False;
                  
               else
                  null;
               end if;
               
            when Sf.Window.Event.sfEvtMouseButtonPressed =>
               if
                 TextEingegeben.mouseButton.button = Sf.Window.Mouse.sfMouseRight
               then
                  NachLogiktask.EingegebenerText := SystemRecordKonstanten.LeerTexteingabe;
                  NachGrafiktask.TextEingabe := False;
                  NachLogiktask.Warten := False;
                  
               else
                  null;
               end if;
               
            when others =>
               null;
         end case;
         
      end loop TextSchleife;
      
   end Texteingabe;
   
   
   
   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
   is begin
      
      CharacterZuText (1) := EingegebenesZeichenExtern;
      
      case
        NachGrafiktask.NameSpielstand
      is
         when True =>
            if
              To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length >= SystemKonstanten.MaximaleZeichenlängeDateisystem
            then
               return;
               
            elsif
              SpielstandlisteLogik.NamePrüfen (NameExtern => CharacterZuText) = False
            then
               return;
               
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
            
      NachLogiktask.EingegebenerText.EingegebenerText := NachLogiktask.EingegebenerText.EingegebenerText & CharacterZuText;
      
   end ZeichenHinzufügen;
   
   
   
   procedure ZeichenEntfernen
   is begin
      
      case
        To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Length
      is
         when 0 =>
            null;
         
         when others =>
            NachLogiktask.EingegebenerText.EingegebenerText := Ada.Strings.Wide_Wide_Unbounded.Delete (Source  => NachLogiktask.EingegebenerText.EingegebenerText,
                                                                                                       From    => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last,
                                                                                                       Through => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText)'Last);
      end case;
      
   end ZeichenEntfernen;

end TexteingabeGrafik;
