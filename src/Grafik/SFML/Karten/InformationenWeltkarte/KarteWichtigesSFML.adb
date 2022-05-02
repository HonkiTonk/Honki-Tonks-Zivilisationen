pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with KartenRecords; use KartenRecords;
with SpielVariablen;
with GlobaleTexte;
with TextKonstanten;

with LeseWichtiges;

with ForschungAllgemein;
with GrafikEinstellungenSFML;

package body KarteWichtigesSFML is

   function WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      case
        SchriftartFestgelegt
      is
         when False =>
            SchriftartFestgelegt := SchriftartFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftgrößeFestgelegt
      is
         when False =>
            SchriftgrößeFestgelegt := SchriftgrößenFestlegen;
            
         when True =>
            null;
      end case;
      
      case
        SchriftfarbeFestgelegt
      is
         when False =>
            SchriftfarbeFestgelegt := SchriftfarbenFestlegen;
            
         when True =>
            null;
      end case;
      
      Textposition := TextpositionExtern;
      Zeilenabstand := Float (GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße) * 0.15;
      
      AktuelleKoordinaten := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
      if
        AktuelleKoordinaten /= LetzteKoordinaten
      then
         WertOhneTrennzeichen := ZahlAlsStringEbeneVorhanden (ZahlExtern => AktuelleKoordinaten.EAchse);
         YAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => AktuelleKoordinaten.YAchse);
         XAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => AktuelleKoordinaten.XAchse);
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (1),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellePosition)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen) & ","
                                            & To_Wide_Wide_String (Source => YAchsenWert) & "," & To_Wide_Wide_String (Source => XAchsenWert));
         Sf.Graphics.Text.setPosition (text     => TextAccess (1),
                                       position => Textposition);
         
         LetzteKoordinaten := AktuelleKoordinaten;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (1)).height;
      
      
            
      ----------------------------------- Wieso gibt es keine Lese/Schreibefunktion für die Rundenanzahl?
      AktuelleRunde := SpielVariablen.RundenAnzahl;
        
      if
        AktuelleRunde /= LetzteRunde
      then
         WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => AktuelleRunde);
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (2),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleRunde)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextAccess (2),
                                       position => Textposition);
         
         LetzteRunde := AktuelleRunde;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (2)).height;
      
      
            
      AktuelleGeldmenge := LeseWichtiges.Geldmenge (RasseExtern => RasseExtern);
      
      if
        AktuelleGeldmenge /= LetzteGeldmenge
      then
         WertOhneTrennzeichen := ZahlAlsStringInteger (ZahlExtern => AktuelleGeldmenge);
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (3),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleGeldmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextAccess (3),
                                       position => Textposition);
         
         LetzteGeldmenge := AktuelleGeldmenge;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (3)).height;
      
      
            
      AktuellerGeldgewinn := LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseExtern);
      
      if
        AktuellerGeldgewinn /= LetzterGeldgewinn
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuellerGeldgewinn);
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (4),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellerGeldzuwachs)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextAccess (4),
                                       position => Textposition);
         
         LetzterGeldgewinn := AktuellerGeldgewinn;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (4)).height;
      
      
      
      AktuellesForschungsprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      if
        AktuellesForschungsprojekt /= LetztesForschungsprojekt
      then
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (5),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellesForschungsprojekt) & " "
                                                                         & ForschungAllgemein.Beschreibung (IDExtern    => AktuellesForschungsprojekt,
                                                                                                            RasseExtern => RasseExtern)));

         Sf.Graphics.Text.setPosition (text     => TextAccess (5),
                                       position => Textposition);
         
         LetztesForschungsprojekt := AktuellesForschungsprojekt;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (5)).height;
      
      
      
      AktuelleForschungszeit := LeseWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
      if
        AktuelleForschungszeit /= LetzteForschungszeit
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuelleForschungszeit);
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (6),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugVerbleibendeForschungszeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextAccess (6),
                                       position => Textposition);
         
         LetzteForschungszeit := AktuelleForschungszeit;
         
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (6)).height;
      
      
      
      AktuelleForschungsmenge := LeseWichtiges.Forschungsmenge (RasseExtern => RasseExtern);
      
      if
        AktuelleForschungsmenge = LetzteForschungsmenge
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuelleForschungsmenge);
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (7),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuelleForschungsmenge)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextAccess (7),
                                       position => Textposition);
      
         LetzteForschungsmenge := AktuelleForschungsmenge;
      
      else
         null;
      end if;
      
      Textposition.y := Textposition.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess (7)).height;
      
      
      
      AktuelleForschungsrate := LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseExtern);
      
      if
        AktuelleForschungsrate = LetzteForschungsrate
      then
         WertOhneTrennzeichen := ZahlAlsStringKostenLager (ZahlExtern => AktuelleForschungsrate);
      
         Sf.Graphics.Text.setUnicodeString (text => TextAccess (8),
                                            str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (TextKonstanten.ZeugAktuellerForschungsgewinn)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
         Sf.Graphics.Text.setPosition (text     => TextAccess (8),
                                       position => Textposition);
         
         LetzteForschungsrate := AktuelleForschungsrate;
         
      else
         null;
      end if;
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                            text         => TextAccess (TextSchleifenwert));
         
      end loop TextSchleife;
      
      return Textposition;
      
   end WichtigesInformationen;
   
   
   
   function SchriftartFestlegen
     return Boolean
   is begin
      
      TextSchleife:
      for TextSchleifenwert in TextAccessArray'Range loop
            
         Sf.Graphics.Text.setFont (text => TextAccess (TextSchleifenwert),
                                   font => GrafikEinstellungenSFML.SchriftartAccess);
            
      end loop TextSchleife;
   
      return True;
      
   end SchriftartFestlegen;



   function SchriftgrößenFestlegen
     return Boolean
   is begin
      
      SchriftgrößeSchleife:
      for SchriftgrößeSchleifenwert in TextAccessArray'Range loop
         
         
         Sf.Graphics.Text.setCharacterSize (text => TextAccess (SchriftgrößeSchleifenwert),
                                            size => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße);
         
      end loop SchriftgrößeSchleife;
      
      return True;

   end SchriftgrößenFestlegen;



   function SchriftfarbenFestlegen
     return Boolean
   is begin
                  
      SchriftfarbeSchleife:
      for SchriftfarbeSchleifenwert in TextAccessArray'Range loop
         
         Sf.Graphics.Text.setColor (text  => TextAccess (SchriftfarbeSchleifenwert),
                                    color => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
         
      end loop SchriftfarbeSchleife;
      
      return True;

   end SchriftfarbenFestlegen;

end KarteWichtigesSFML;
