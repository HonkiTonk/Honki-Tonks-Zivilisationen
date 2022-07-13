pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with GlobaleTexte;
with TextKonstanten;

with LeseWichtiges;

with ForschungAllgemein;
with GrafikEinstellungenSFML;
with TextaccessVariablen;

package body KarteWichtigesSFML is

   function WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition := TextpositionExtern;
      Zeilenabstand := Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard) * 0.15;
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
      WertOhneTrennzeichen := ZahlAlsStringEbeneVorhanden (ZahlExtern => AktuelleKoordinaten.EAchse);
      YAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => AktuelleKoordinaten.YAchse);
      XAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => AktuelleKoordinaten.XAchse);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (1),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellePosition)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen) & ","
                                         & To_Wide_Wide_String (Source => YAchsenWert) & "," & To_Wide_Wide_String (Source => XAchsenWert));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (1),
                                    position => Textposition);
               
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (1)).height;
      
      
            
      -- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl? äöü
      WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => SpielVariablen.Allgemeines.Rundenanzahl);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (2),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleRunde)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (2),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (2)).height;
      
      
                  
      WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (3),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleGeldmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (3),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (3)).height;
      
      
                  
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (4),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellerGeldzuwachs)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (4),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (4)).height;
      
      
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (5),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellesForschungsprojekt) & " "
                                                                      & ForschungAllgemein.Beschreibung (IDExtern    => LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern),
                                                                                                         RasseExtern => RasseExtern)));

      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (5),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (5)).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (6),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerbleibendeForschungszeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (6),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (6)).height;
      
      
      
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (7),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleForschungsmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (7),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (7)).height;
      
      
            
      WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (8),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellerForschungsgewinn)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (8),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (8)).height;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteWichtigesAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      return Textposition;
      
   end WichtigesInformationen;

end KarteWichtigesSFML;
