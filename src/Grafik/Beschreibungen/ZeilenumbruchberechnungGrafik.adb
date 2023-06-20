with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics.Text;

with TextKonstanten;
with TextaccessVariablen;

package body ZeilenumbruchberechnungGrafik is
   
   function Zeilenumbruchberechnung
     (TextExtern : in Wide_Wide_String;
      TextfeldbreiteExtern : in Float;
      BreitenabzugExtern : in Float)
      return Wide_Wide_String
   is begin
            
      case
        TextExtern'Length
      is
         when 0 =>
            return TextKonstanten.LeerString;
            
         when others =>
            NeuerText := TextKonstanten.LeerUnboundedString;
      
            -- Sollte TextExtern'First nicht immer 1 sein? äöü
            SchleifenAnfang := TextExtern'First;
            SchleifenEnde := TextExtern'Last;
            
            Textfeldbreite := TextfeldbreiteExtern * Textfeldbreitenmultiplikator - BreitenabzugExtern;
      end case;
      
      ZeilenumbruchSchleife:
      loop
         
         if
           SchleifenAnfang > SchleifenEnde
         then
            exit ZeilenumbruchSchleife;
            
         else
            Zwischenwert := -1;
         end if;
      
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
              Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ZeilenumbruchAccess).width >= Textfeldbreite
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
      
   end Zeilenumbruchberechnung;

end ZeilenumbruchberechnungGrafik;
