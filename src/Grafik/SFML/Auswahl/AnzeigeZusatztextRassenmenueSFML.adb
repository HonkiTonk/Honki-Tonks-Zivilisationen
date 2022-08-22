pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with MenueDatentypen;
with TextaccessVariablen;

with GrafikEinstellungenSFML;
with InteraktionAuswahl;
with BeschreibungenZeilenumbruchSFML;
with RassenbeschreibungenSFML;

package body AnzeigeZusatztextRassenmenueSFML is

   procedure AnzeigeZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive)
   is begin
      
      RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern);
            
      PositionHintergrund := ((GrafikEinstellungenSFML.AktuelleFensterAuflösung.x + GrafikEinstellungenSFML.AktuelleFensterAuflösung.x / 100.00) / 2.00,
                              InteraktionAuswahl.PositionenMenüeinträge (MenueDatentypen.Rassen_Menü_Enum, 1).top);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                    position => (PositionHintergrund.x + AnfangsabstandExtratext, PositionHintergrund.y));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                         str  => BeschreibungenZeilenumbruchSFML.ZeilenumbruchBerechnen (TextExtern => RassenbeschreibungenSFML.BeschreibungLang (RasseExtern => RasseAnzeigen)));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen));
      
   end AnzeigeZusatztextRassenmenü;

end AnzeigeZusatztextRassenmenueSFML;
