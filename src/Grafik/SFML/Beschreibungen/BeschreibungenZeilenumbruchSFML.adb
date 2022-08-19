pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics.Text;

with TextKonstanten;
with TextaccessVariablen;

with GrafikEinstellungenSFML;

package body BeschreibungenZeilenumbruchSFML is

   function ZeilenumbruchBerechnen
     (TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      AktuellerTextbereichZwei := TextKonstanten.LeerUnboundedString;
      
      -- Den Multiplikator mitübergeben? äöü
      -- Wäre vielleicht sinnvoll bei unterschiedlichen Menüarten. äöü
      BreiteTextfeld := GrafikEinstellungenSFML.AktuelleFensterAuflösung.x * 0.50 - 2.00 * TextKonstanten.StartpositionText.x;
      SchleifenAnfang := 1;
      SchleifenEnde := TextExtern'Last;
      
      ZeilenumbruchSchleife:
      loop
         
         AktuellerTextbereichEins := TextKonstanten.LeerUnboundedString;
         Zwischenwert := -1;
      
         TextbereichSchleife:
         for TextbereichSchleifenwert in SchleifenAnfang .. SchleifenEnde loop
         
            AktuellerTextbereichEins := AktuellerTextbereichEins & TextExtern (TextbereichSchleifenwert);
            
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZeilenumbruchAccess,
                                               str  => To_Wide_Wide_String (Source => AktuellerTextbereichEins));
            
            if
              TextExtern (TextbereichSchleifenwert) = Ada.Characters.Wide_Wide_Latin_1.Space
            then
               Zwischenwert := TextbereichSchleifenwert;
               
            else
               null;
            end if;
         
            if
              Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ZeilenumbruchAccess).width >= BreiteTextfeld
            then
               case
                 Zwischenwert
               is
                  when -1 =>
                     AktuellerTextbereichZwei := AktuellerTextbereichZwei & AktuellerTextbereichEins & Ada.Characters.Wide_Wide_Latin_1.LF;
                     SchleifenAnfang := TextbereichSchleifenwert + 1;
                     
                  when others =>
                     AktuellerTextbereichZwei := AktuellerTextbereichZwei & TextExtern (SchleifenAnfang .. Zwischenwert - 1) & Ada.Characters.Wide_Wide_Latin_1.LF;
                     SchleifenAnfang := Zwischenwert + 1;
               end case;
               
               exit TextbereichSchleife;
               
            elsif
              TextbereichSchleifenwert >= SchleifenEnde
            then
               AktuellerTextbereichZwei := AktuellerTextbereichZwei & AktuellerTextbereichEins;
               exit ZeilenumbruchSchleife;
            
            else
               null;
            end if;
            
         end loop TextbereichSchleife;
      end loop ZeilenumbruchSchleife;
      
      return To_Wide_Wide_String (Source => AktuellerTextbereichZwei);
      
   end ZeilenumbruchBerechnen;

end BeschreibungenZeilenumbruchSFML;
