pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics.Text;

with TextKonstanten;
with TextaccessVariablen;

with GrafikEinstellungenSFML;

package body BeschreibungenZeilenumbruchSFML is

   -- Hierfür noch einen schnelleren Weg finden. äöü
   function ZeilenumbruchBerechnen
     (TextExtern : in Wide_Wide_String;
      BreiteExtern : in Float)
      return Wide_Wide_String
   is begin
      
      NeuerText := TextKonstanten.LeerUnboundedString;
      
      BreiteTextfeld := GrafikEinstellungenSFML.AktuelleFensterAuflösung.x * BreiteExtern - TextKonstanten.TextbreiteZusatzwert;
      SchleifenAnfang := 1;
      SchleifenEnde := TextExtern'Last;
      
      ZeilenumbruchSchleife:
      loop
         
         Zwischenwert := -1;
      
         TextbereichSchleife:
         for TextbereichSchleifenwert in SchleifenAnfang .. SchleifenEnde loop
                     
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZeilenumbruchAccess,
                                               str  => TextExtern (SchleifenAnfang .. TextbereichSchleifenwert));
            
            case
              TextExtern (TextbereichSchleifenwert)
            is
               when Ada.Characters.Wide_Wide_Latin_1.Space =>
                  Zwischenwert := TextbereichSchleifenwert;
               
               when others =>
                  null;
            end case;
         
            if
              Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ZeilenumbruchAccess).width >= BreiteTextfeld
            then
               case
                 Zwischenwert
               is
                  when -1 =>
                     NeuerText := NeuerText & TextExtern (SchleifenAnfang .. TextbereichSchleifenwert) & Ada.Characters.Wide_Wide_Latin_1.LF;
                     SchleifenAnfang := TextbereichSchleifenwert + 1;
                     
                  when others =>
                     NeuerText := NeuerText & TextExtern (SchleifenAnfang .. Zwischenwert - 1) & Ada.Characters.Wide_Wide_Latin_1.LF;
                     SchleifenAnfang := Zwischenwert + 1;
               end case;
               
               exit TextbereichSchleife;
               
            elsif
              TextbereichSchleifenwert >= SchleifenEnde
            then
               NeuerText := NeuerText & TextExtern (SchleifenAnfang .. TextbereichSchleifenwert);
               exit ZeilenumbruchSchleife;
            
            else
               null;
            end if;
            
         end loop TextbereichSchleife;
      end loop ZeilenumbruchSchleife;
      
      return To_Wide_Wide_String (Source => NeuerText);
      
   end ZeilenumbruchBerechnen;

end BeschreibungenZeilenumbruchSFML;
