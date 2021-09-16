pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten, GlobaleTexte;

with LeseKarten;

with Anzeige, Cheat, EinheitSuchen, StadtSuchen, StadtInformationen, VerbesserungenAllgemein, KartenAllgemein, GesamtwerteFeld, InformationenWichtiges, InformationenEinheiten;
     
package body KarteInformationen is

   procedure KarteInformation
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      InformationenWichtiges.Wichtiges (RasseExtern => RasseExtern);
      InformationenSichtbar (RasseExtern => RasseExtern);      
      Kartenposition (RasseExtern => RasseExtern);
      Gecheatet (RasseExtern => RasseExtern);
      
   end KarteInformation;
   
   
   
   procedure InformationenSichtbar
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sichtbar := LeseKarten.Sichtbar (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                       RasseExtern    => RasseExtern);
      
      case
        Sichtbar
      is
         when True =>
            EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);
            
            if
              EinheitRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
            then
               null;
                
            else
               InformationenEinheiten.Einheiten (RasseExtern              => RasseExtern,
                                                 EinheitRasseNummerExtern => EinheitRasseNummer);
            end if;
            
         when False =>
            null;
      end case;
      
      case
        Sichtbar
      is
         when True =>
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);

            if
              StadtRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
            then
               null;
                     
            else
               InformationenStadt (RasseExtern            => RasseExtern,
                                   StadtRasseNummerExtern => StadtRasseNummer);
            end if;
            
         when False =>
            null;
      end case;
      
      case
        Sichtbar
      is
         when True =>
            InformationenAllgemein (RasseExtern => RasseExtern);
            
         when False =>
            null;
      end case;
      
      New_Line;
      
   end InformationenSichtbar;
   
         
   
   procedure InformationenStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      StadtInformationen.Stadt (RasseExtern            => RasseExtern,
                                StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- Debuginformationen, nur sichtbar wenn Cheat aktiviert ist
      case
        Cheat.FeindlicheInformationenSehen
      is
         when False =>
            null;
                                 
         when True =>
            Cheat.KarteStadtInfos (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end InformationenStadt;
   
   
   
   procedure InformationenAllgemein
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Hügel (RasseExtern => RasseExtern);
      KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Ressource (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
      VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungGebiet (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
      VerbesserungenAllgemein.Beschreibung (KartenVerbesserungExtern => LeseKarten.VerbesserungWeg (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
      KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Fluss (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
      New_Line;
            
      FeldVerteidigung (RasseExtern => RasseExtern);
      FeldAngriff (RasseExtern => RasseExtern);
      FeldNahrung (RasseExtern => RasseExtern);
      FeldProduktion (RasseExtern => RasseExtern);
      FeldGeld (RasseExtern => RasseExtern);
      FeldWissen (RasseExtern => RasseExtern);
      
   end InformationenAllgemein;
   
   
   
   procedure Hügel
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseKarten.Hügel (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position) = True
      then
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => GlobaleDatentypen.Karten_Grund_Enum'Pos (GlobaleDatentypen.Hügel_Mit),
                                        LetzteZeileExtern      => GlobaleDatentypen.Karten_Grund_Enum'Pos (GlobaleDatentypen.Hügel_Mit),
                                        AbstandAnfangExtern    => GlobaleTexte.Leer,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Leer);
         
      else
         null;
      end if;
         
      KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position));
      
   end Hügel;
   
   
   
   procedure FeldVerteidigung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 19,
                                     LetzteZeileExtern      => 19,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                   RasseExtern       => RasseExtern)),
                               Width => 1);
      
   end FeldVerteidigung;
   
   
   
   procedure FeldAngriff
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 59,
                                     LetzteZeileExtern      => 59,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldAngriff (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                              RasseExtern       => RasseExtern)),
                               Width => 1);
      
   end FeldAngriff;
   
   
   
   procedure FeldNahrung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 20,
                                     LetzteZeileExtern      => 20,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldNahrung (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                              RasseExtern       => RasseExtern)),
                               Width => 1);
      New_Line;
      
   end FeldNahrung;
   
   
   
   procedure FeldProduktion
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 21,
                                     LetzteZeileExtern      => 21,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldProduktion (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                                 RasseExtern       => RasseExtern)),
                               Width => 1);
      
   end FeldProduktion;
   
   
   
   procedure FeldGeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 22,
                                     LetzteZeileExtern      => 22,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldGeld (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                           RasseExtern       => RasseExtern)),
                               Width => 1);
      
   end FeldGeld;
   
   
   
   procedure FeldWissen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 23,
                                     LetzteZeileExtern      => 23,
                                     AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldWissen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                             RasseExtern       => RasseExtern)),
                               Width => 1);
      New_Line;
      
   end FeldWissen;
   
   
   
   procedure Kartenposition
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 58,
                                     LetzteZeileExtern      => 58,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Leer,
                                     AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      Put_Line (Item => GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse'Wide_Wide_Image & "," & GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse'Wide_Wide_Image
                & "," & GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse'Wide_Wide_Image);
      New_Line;
      
   end Kartenposition;
   
   
   
   procedure Gecheatet
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        Cheat.FeindlicheInformationenSehen
      is
         when False =>
            null;
            
         when True =>
            Cheat.KarteInfosFeld (RasseExtern => RasseExtern);
      end case;
      
   end Gecheatet;

end KarteInformationen;
