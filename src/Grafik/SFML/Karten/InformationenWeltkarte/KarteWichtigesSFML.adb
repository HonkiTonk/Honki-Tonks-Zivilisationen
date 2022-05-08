pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with SpielVariablen;
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
      
      if
        AktuelleKoordinaten /= LetzteKoordinaten
      then
         WertOhneTrennzeichen := ZahlAlsStringEbeneVorhanden (ZahlExtern => AktuelleKoordinaten.EAchse);
         YAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => AktuelleKoordinaten.YAchse);
         XAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => AktuelleKoordinaten.XAchse);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (1),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellePosition)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen) & ","
                                            & To_Wide_Wide_String (Source => YAchsenWert) & "," & To_Wide_Wide_String (Source => XAchsenWert));
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (1),
                                       position => Textposition);
         
         LetzteKoordinaten := AktuelleKoordinaten;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (1)).height;
      
      
            
      ----------------------------------- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl?
      AktuelleRunde := SpielVariablen.RundenAnzahl;
        
      if
        AktuelleRunde /= LetzteRunde
      then
         WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => AktuelleRunde);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (2),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleRunde)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (2),
                                       position => Textposition);
         
         LetzteRunde := AktuelleRunde;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (2)).height;
      
      
            
      AktuelleGeldmenge := LeseWichtiges.Geldmenge (RasseExtern => RasseExtern);
      
      if
        AktuelleGeldmenge /= LetzteGeldmenge
      then
         WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => AktuelleGeldmenge);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (3),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleGeldmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (3),
                                       position => Textposition);
         
         LetzteGeldmenge := AktuelleGeldmenge;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (3)).height;
      
      
            
      AktuellerGeldgewinn := LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern);
      
      if
        AktuellerGeldgewinn /= LetzterGeldgewinn
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuellerGeldgewinn);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (4),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellerGeldzuwachs)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (4),
                                       position => Textposition);
         
         LetzterGeldgewinn := AktuellerGeldgewinn;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (4)).height;
      
      
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt /= LetztesForschungsprojekt
      then
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (5),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellesForschungsprojekt) & " "
                                                                         & ForschungAllgemein.Beschreibung (IDExtern    => AktuellesForschungsprojekt,
                                                                                                            RasseExtern => RasseExtern)));

         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (5),
                                       position => Textposition);
         
         LetztesForschungsprojekt := AktuellesForschungsprojekt;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (5)).height;
      
      
      
      AktuelleForschungszeit := LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
      if
        AktuelleForschungszeit /= LetzteForschungszeit
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuelleForschungszeit);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (6),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerbleibendeForschungszeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (6),
                                       position => Textposition);
         
         LetzteForschungszeit := AktuelleForschungszeit;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (6)).height;
      
      
      
      AktuelleForschungsmenge := LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern);
      
      if
        AktuelleForschungsmenge = LetzteForschungsmenge
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuelleForschungsmenge);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (7),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleForschungsmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (7),
                                       position => Textposition);
      
         LetzteForschungsmenge := AktuelleForschungsmenge;
      
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteWichtigesAccess (7)).height;
      
      
      
      AktuelleForschungsrate := LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern);
      
      if
        AktuelleForschungsrate = LetzteForschungsrate
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuelleForschungsrate);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteWichtigesAccess (8),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuellerForschungsgewinn)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteWichtigesAccess (8),
                                       position => Textposition);
         
         LetzteForschungsrate := AktuelleForschungsrate;
         
      else
         null;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteWichtigesAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      return Textposition;
      
   end WichtigesInformationen;

end KarteWichtigesSFML;
