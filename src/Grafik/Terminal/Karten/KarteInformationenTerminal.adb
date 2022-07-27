pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Integer_Wide_Wide_Text_IO;

with EinheitenDatentypen; use EinheitenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with LeseKarten;

with EinheitSuchen;
with StadtSuchen;
with StadtInformationenTerminal;
with AufgabenAllgemein;
with KartenAllgemein;
with GesamtwerteFeld;
with InformationenWichtigesTerminal;
with InformationenEinheitenTerminal;
with DebugmenueTerminal;
     
package body KarteInformationenTerminal is

   procedure KarteInformationenTerminal
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      InformationenWichtigesTerminal.Wichtiges (RasseExtern => RasseExtern);
      InformationenSichtbar (RasseExtern => RasseExtern);
      KartenKoordinaten (RasseExtern => RasseExtern);
      DebugInformationen (RasseExtern => RasseExtern);
      
   end KarteInformationenTerminal;
   
   
   
   procedure InformationenSichtbar
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sichtbar := LeseKarten.Sichtbar (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                       RasseExtern       => RasseExtern);
      
      case
        Sichtbar
      is
         when True =>
            EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
            
            if
              EinheitRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
            then
               null;
                
            else
               InformationenEinheitenTerminal.Einheiten (RasseExtern              => RasseExtern,
                                                        EinheitRasseNummerExtern => EinheitRasseNummer);
            end if;
            
         when False =>
            null;
      end case;
      
      case
        Sichtbar
      is
         when True =>
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);

            if
              StadtRasseNummer.Nummer = StadtKonstanten.LeerNummer
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      StadtInformationenTerminal.Stadt (RasseExtern            => RasseExtern,
                                       StadtRasseNummerExtern => StadtRasseNummerExtern);

      case
        SpielVariablen.Debug.VolleInformation
      is
         when False =>
            null;
                                 
         when True =>
           DebugmenueTerminal.KarteStadtInfos (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end InformationenStadt;
   
   
   
   procedure InformationenAllgemein
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Hügel (RasseExtern => RasseExtern);
      
      KartenRessource := LeseKarten.Ressource (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        KartenRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            null;
            
         when others =>
            Put (Item => KartenAllgemein.BeschreibungRessource (KartenRessourceExtern => KartenRessource));
      end case;
      
      KartenVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        KartenVerbesserung
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
            
         when others =>
            Put_Line (Item => AufgabenAllgemein.BeschreibungVerbesserung (KartenVerbesserungExtern => KartenVerbesserung));
      end case;
      
      KartenWeg := LeseKarten.Weg (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        KartenWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            Put_Line (Item => AufgabenAllgemein.BeschreibungWeg (KartenWegExtern => KartenWeg));
      end case;
      
      KarteFluss := LeseKarten.Fluss (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell);
      
      case
        KarteFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            null;
            
         when others =>
            Put (Item => KartenAllgemein.BeschreibungFluss (KartenFlussExtern => KarteFluss));
      end case;
      
      New_Line;
            
      FeldVerteidigung (RasseExtern => RasseExtern);
      FeldAngriff (RasseExtern => RasseExtern);
      FeldNahrung (RasseExtern => RasseExtern);
      FeldProduktion (RasseExtern => RasseExtern);
      FeldGeld (RasseExtern => RasseExtern);
      FeldWissen (RasseExtern => RasseExtern);
      
   end InformationenAllgemein;
   
   
   
   procedure Hügel
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        LeseKarten.BasisGrund (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            null;
         
         when others =>
            --   TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
            --                                            TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
            --                                            ÜberschriftZeileExtern => 0,
            --                                            ErsteZeileExtern       => KartengrundDatentypen.Kartengrund_Enum'Pos (KartengrundDatentypen.Hügel_Mit_Enum),
            --                                            LetzteZeileExtern      => KartengrundDatentypen.Kartengrund_Enum'Pos (KartengrundDatentypen.Hügel_Mit_Enum),
            --                                            AbstandAnfangExtern    => GlobaleTexte.Leer,
            --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
            --                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            null;
      end case;
      
      -- Grund sollte niemals leer sein, da man in der Terminal das Spielfeld nicht verlassen kann mit dem Zeiger.
      Put (Item => KartenAllgemein.BeschreibungZusatzgrund (KartenGrundExtern => LeseKarten.AktuellerGrund (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell)));
      
   end Hügel;
   
   
   
   procedure FeldVerteidigung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 19,
      --                                          LetzteZeileExtern      => 19,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                             RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldVerteidigung;
   
   
   
   procedure FeldAngriff
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 59,
      --                                          LetzteZeileExtern      => 59,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldAngriff (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                        RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldAngriff;
   
   
   
   procedure FeldNahrung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
       --                                         ErsteZeileExtern       => 20,
       --                                         LetzteZeileExtern      => 20,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldNahrung (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                        RasseExtern       => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end FeldNahrung;
   
   
   
   procedure FeldProduktion
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
    --  TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
      --                                          TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 21,
      --                                          LetzteZeileExtern      => 21,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldProduktion (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                           RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldProduktion;
   
   
   
   procedure FeldGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 22,
      --                                          LetzteZeileExtern      => 22,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
       --                                         AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldGeld (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                     RasseExtern       => RasseExtern)),
                                         Width => 1);
      
   end FeldGeld;
   
   
   
   procedure FeldWissen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
     --                                           ÜberschriftZeileExtern => 0,
     --                                           ErsteZeileExtern       => 23,
      --                                          LetzteZeileExtern      => 23,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Großer_Abstand,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
      --                                          AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      Ada.Integer_Wide_Wide_Text_IO.Put (Item  => Integer (GesamtwerteFeld.FeldWissen (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                       RasseExtern       => RasseExtern)),
                                         Width => 1);
      New_Line;
      
   end FeldWissen;
   
   
   
   procedure KartenKoordinaten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
     -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
     --                                           TextDateiExtern        => GlobaleTexte.Zeug,
      --                                          ÜberschriftZeileExtern => 0,
      --                                          ErsteZeileExtern       => 57,
      --                                          LetzteZeileExtern      => 57,
      --                                          AbstandAnfangExtern    => GlobaleTexte.Leer,
      --                                          AbstandMitteExtern     => GlobaleTexte.Leer,
       --                                         AbstandEndeExtern      => GlobaleTexte.Kleiner_Abstand);
      
      WertOhneTrennzeichen := ZahlAlsStringEbeneVorhanden (ZahlExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse);
      YAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse);
      XAchsenWert := ZahlAlsStringKartenfeldPositivMitNullwert (ZahlExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse);
      
      Put_Line (Item => To_Wide_Wide_String (Source => WertOhneTrennzeichen) & ", " & To_Wide_Wide_String (Source => YAchsenWert) & ", " & To_Wide_Wide_String (Source => XAchsenWert));
      New_Line;
      
   end KartenKoordinaten;
   
   
   
   procedure DebugInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.Debug.VolleInformation
      is
         when False =>
            null;
            
         when True =>
          DebugmenueTerminal.KarteInfosFeld (RasseExtern => RasseExtern);
      end case;
      
   end DebugInformationen;

end KarteInformationenTerminal;
