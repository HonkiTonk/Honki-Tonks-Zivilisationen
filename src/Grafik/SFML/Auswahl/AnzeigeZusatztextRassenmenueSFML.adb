pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Characters.Wide_Wide_Latin_1;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with TextKonstanten;
with MenueDatentypen;

with GrafikEinstellungenSFML;
with AuswahlMenuesStringsSetzen;
with InteraktionAuswahl;
with HintergrundSFML;

-- Muss alles noch einmal ein wenig besser geschrieben sein. äöü
package body AnzeigeZusatztextRassenmenueSFML is

   procedure AnzeigeZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive)
   is begin
      
      RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern);
      
      Textbearbeitung (AktuelleRasseExtern => RasseAnzeigen);
      
      HintergrundSFML.TextHintergrund (LinksRechtsExtern        => False,
                                       AbstandÜberschriftExtern => InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Rassen_Menü_Enum, 1).top,
                                       VerhältnisTextfeldExtern => VerhältnisTextfeld,
                                       StartpositionExtern      => PositionHintergrund.x);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextRassenAccess (RasseAnzeigen),
                                         str  => ZeilenumbruchEinbauen (RasseExtern => RasseAnzeigen,
                                                                        TextExtern  => To_Wide_Wide_String (Source => RassenTexte (RasseAnzeigen))));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.ZusatztextRassenAccess (RasseAnzeigen));
      
   end AnzeigeZusatztextRassenmenü;
   
   
   
   -- Noch weiter verallgemeinern und dann überall benutzen. äöü
   function ZeilenumbruchEinbauen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextExtern : in Wide_Wide_String)
      return Wide_Wide_String
   is begin
      
      AktuellerTextbereichZwei := TextKonstanten.LeerUnboundedString;
      
      -- Das muss für eine Verallgemeinerung vermutlich mit übergeben werden.
      BreiteTextfeld := GrafikEinstellungenSFML.AktuelleFensterAuflösung.x * VerhältnisTextfeld.x - EndabstandExtratext;
         
      SchleifenAnfang := 1;
      SchleifenEnde := TextExtern'Last;
      
      ZeilenumbruchSchleife:
      loop
         
         AktuellerTextbereichEins := TextKonstanten.LeerUnboundedString;
         Zwischenwert := -1;
         
         TextbereichSchleife:
         for TextbereichSchleifenwert in SchleifenAnfang .. SchleifenEnde loop
         
            AktuellerTextbereichEins := AktuellerTextbereichEins & TextExtern (TextbereichSchleifenwert);
            
            -- Das muss für die Verallgemeinerung auf einen einfachen Textaccess zugreifen.
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ZusatztextRassenAccess (RasseExtern),
                                               str  => To_Wide_Wide_String (Source => AktuellerTextbereichEins));
            
            if
              TextExtern (TextbereichSchleifenwert) = Ada.Characters.Wide_Wide_Latin_1.Space
            then
               Zwischenwert := TextbereichSchleifenwert;
               
            else
               null;
            end if;
            
            if
              Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.ZusatztextRassenAccess (RasseExtern)).width >= BreiteTextfeld
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
      
   end ZeilenumbruchEinbauen;
   
   
   
   procedure Textbearbeitung
     (AktuelleRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         -- Hier direkt auf die GlobaleTexte zugreifen? äöü
         RassenTexte (RasseSchleifenwert) :=
           To_Unbounded_Wide_Wide_String (Source => AuswahlMenuesStringsSetzen.AuswahlMenüZusatztextStringSetzen (WelcheZeileExtern => 2 * RassenDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert),
                                                                                                                   WelchesMenüExtern => MenueDatentypen.Rassen_Menü_Enum));
         
      end loop RassenSchleife;
      
      PositionHintergrund := ((GrafikEinstellungenSFML.AktuelleFensterAuflösung.x + GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 100.00) / 2.00,
                              InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Rassen_Menü_Enum, 1).top);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ZusatztextRassenAccess (AktuelleRasseExtern),
                                    position => (PositionHintergrund.x + AnfangsabstandExtratext, PositionHintergrund.y));
      
   end Textbearbeitung;

end AnzeigeZusatztextRassenmenueSFML;
