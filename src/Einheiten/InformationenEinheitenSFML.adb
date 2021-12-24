pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenBeschreibungen;
with KampfwerteEinheitErmitteln;
with Cheat;
with GrafikTextAllgemein;
with GrafikEinstellungen;
with StadtInformationenSFML;

package body InformationenEinheitenSFML is

   function Einheiten
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionTextExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      PositionText := PositionTextExtern;
      Zeilenabstand := Float (GrafikEinstellungen.FensterEinstellungen.Schriftgröße) * 0.15;
      
      GrafikTextAllgemein.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                                FontExtern         => GrafikEinstellungen.Schriftart,
                                                SchriftgrößeExtern => GrafikEinstellungen.FensterEinstellungen.Schriftgröße,
                                                FarbeExtern        => GrafikEinstellungen.Schriftfarben.FarbeStandardText);
      
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitRasseNummer := Allgemeines (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      if
        RasseExtern = EinheitRasseNummerExtern.Rasse
        or
          Cheat.FeindlicheInformationenSehen
      then
         Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer);
         Angriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Verteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Rang (EinheitRasseNummerExtern => EinheitRasseNummer);
         Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuelleVerteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuellerAngriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Ladung (EinheitRasseNummerExtern => EinheitRasseNummer);
         
      else
         null;
      end if;
      
      Gecheatet (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      return PositionText;
      
   end Einheiten;
   
   
   
   function Allgemeines
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.RassePlatznummerRecord
   is begin
            
      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitNummer := EinheitRasseNummerExtern.Platznummer;
                        
         when others =>
            EinheitNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
      return (EinheitRasseNummerExtern.Rasse, EinheitNummer);
      
   end Allgemeines;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (14)) & LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image
                                         & Trennzeichen & LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (15)) & LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image
                                         & Trennzeichen & LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (16)) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image
                                         & Trennzeichen & LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                      IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Erfahrungspunkte;
   
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (17))
                                         & EinheitenBeschreibungen.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Beschäftigung;
   
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (18))
                                         & LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Beschäftigungszeit;
   
   
   
   procedure Angriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (24))
                                         & LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Angriff;
   
   
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (25))
                                         & LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Verteidigung;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (26)) & LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image
                                         & Trennzeichen & LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Rang;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
         
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerNummer =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (51)) & To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (52)));
               
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (51)) 
                                               & StadtInformationenSFML.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                              LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern))));
      end case;
      
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end Heimatstadt;
   
   
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (60)) & KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                                        AngreiferExtern          => False)'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (61)) & KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                                    AngreiferExtern          => False)'Wide_Wide_Image);
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionText);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                         text         => TextAccess);
      
      PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
      
   end AktuellerAngriff;
   
   
   
   procedure Ladung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDEinheit)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            null;
               
         when others =>
            ErsteAnzeige := True;
            
            LadungSchleife:
            for LadungSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                 IDExtern    => IDEinheit) loop
                  
               if
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
                 and
                   ErsteAnzeige
               then
                  ErsteAnzeige := False;
      
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.ZeugSachen (50)));
                  Sf.Graphics.Text.setPosition (text     => TextAccess,
                                                position => PositionText);
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                                     text         => TextAccess);
      
                  PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
                  
                  
      
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz
                                                       (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                         LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                            PlatzExtern              => LadungSchleifenwert)))));
                  Sf.Graphics.Text.setPosition (text     => TextAccess,
                                                position => PositionText);
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                                     text         => TextAccess);
      
                  PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
                  
               elsif
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
               then
                  Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz
                                                       (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                         LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                            PlatzExtern              => LadungSchleifenwert)))));
                  Sf.Graphics.Text.setPosition (text     => TextAccess,
                                                position => PositionText);
                  Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungen.Fenster,
                                                     text         => TextAccess);
      
                  PositionText.y := PositionText.y + Zeilenabstand + Sf.Graphics.Text.getLocalBounds (text => TextAccess).height;
                  
               else
                  null;
               end if;
            
            end loop LadungSchleife;
      end case;
      
   end Ladung;
   
   
   
   procedure Gecheatet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        Cheat.FeindlicheInformationenSehen
      is
         when False =>
            null;
            
         when True =>
            Cheat.KarteInfosEinheiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);                     
      end case;
      
   end Gecheatet;

end InformationenEinheitenSFML;
