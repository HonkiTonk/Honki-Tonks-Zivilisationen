pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with KartenDatentypen; use KartenDatentypen;
with KartenRecords; use KartenRecords;
with StadtDatentypen; use StadtDatentypen;
with KartenKonstanten;
with StadtKonstanten;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with TextKonstanten;
with EinheitenKonstanten;

with LeseKarten;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with Karten;
with StadtInformationenTerminal;
with GebaeudebeschreibungenSFML;
with KartenAllgemein;
with GrafischeAnzeigeTerminal;
with FarbgebungTerminal;
with EingeleseneGrafikenTerminal;

package body KarteStadtTerminal is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      InformationenStadtAufrufen := False;

      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtInformationenTerminal.Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
                                       StadtRasseNummerExtern => StadtRasseNummerExtern);

      case
        InformationenStadtAufrufen
      is
         when True =>
            WeitereInformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);

         when False =>
            null;
      end case;
      
      GebäudeText (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      New_Line;
      
   end AnzeigeStadt;
   
   
   
   procedure GebäudeText
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Aufschlag := AufschlagGebäude (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      case
        Aufschlag
      is
         when KartenDatentypen.SichtweiteNatural'First =>
            null;
            
         when others =>
            Aufschlag := Aufschlag - 1;
            if
              LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 WelchesGebäudeExtern  => StadtDatentypen.GebäudeID (SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse + Aufschlag * 12))
              = True
            then
               Put_Line (Item => GebaeudebeschreibungenSFML.BeschreibungKurz (IDExtern => StadtDatentypen.GebäudeID (SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse + Aufschlag * 12)));
            
            else
               null;
            end if;
      end case;

      New_Line;
      
   end GebäudeText;
   
   
   
   function AufschlagGebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteNatural
   is begin
      
      if
        ((SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = 1
          or
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = 2)
         and
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse <= 12)
        or
          (SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse = 3
           and
             SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse <= 2)
      then
         return SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse;
         
      else
         return KartenDatentypen.SichtweiteNatural'First;
      end if;
      
   end AufschlagGebäude;
     
   
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      YAchsenabstraktion := -Stadtumgebungsgröße;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.StadtkarteArray'Range (1) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.StadtkarteArray'Range (2) loop
                
            case
              Darstellung (YAchseExtern           => YAchseSchleifenwert,
                           XAchseExtern           => XAchseSchleifenwert,
                           StadtRasseNummerExtern => StadtRasseNummerExtern)
            is
               when True =>
                  exit XAchseSchleife;
                  
               when False =>
                  null;
            end case;

            case
              XAchseSchleifenwert
            is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GrafischeDarstellung;
   
   
   
   function Darstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      if
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern > Karten.Stadtkarte'Last (2) - 7
      then               
         AnsichtUmgebung (YAchseExtern           => YAchseExtern,
                          XAchseExtern           => XAchseExtern,
                          StadtRasseNummerExtern => StadtRasseNummerExtern);
         return True;
               
      elsif
        SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt = (YAchseExtern, XAchseExtern)
      then
         CursorDarstellung (YAchseExtern => YAchseExtern,
                            XAchseExtern => XAchseExtern,
                            RasseExtern  => StadtRasseNummerExtern.Rasse);

      elsif
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern = Karten.Stadtkarte'Last (2) - 7
      then
         Put (Item => TextKonstanten.LeerZeichen);

      elsif
        YAchseExtern = Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern >= Karten.Stadtkarte'Last (2) - 7
      then
         Put (Item => TextKonstanten.LeerZeichen);

      elsif
        YAchseExtern = 1
        and
          XAchseExtern < 13
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => StadtDatentypen.GebäudeID (XAchseExtern));
               
      elsif
        YAchseExtern = 2
        and
          XAchseExtern < 13
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => StadtDatentypen.GebäudeID (XAchseExtern) + 12);
               
      elsif
        YAchseExtern = 3
        and
          XAchseExtern < 3
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => StadtDatentypen.GebäudeID (XAchseExtern) + 24);

      else
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                   RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
      return False;
      
   end Darstellung;
   
   
   
   procedure GebäudeDarstellung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
   is begin
      
      if
        LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           WelchesGebäudeExtern  => IDExtern)
        = True
      then
         Put (Item => EingeleseneGrafikenTerminal.GebäudeGrafik (StadtRasseNummerExtern.Rasse, IDExtern));

      else
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                   RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
   end GebäudeDarstellung;
   
   
   
   procedure CursorDarstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        (YAchseExtern < Karten.Stadtkarte'First (1) + 7
         and
           XAchseExtern = Karten.Stadtkarte'Last (2) - 7)
        or
          (YAchseExtern = Karten.Stadtkarte'First (1) + 7
           and
             XAchseExtern >= Karten.Stadtkarte'Last (2) - 7)
      then
         FarbgebungTerminal.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                    VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                    WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                    GrundExtern        => KartengrundDatentypen.Leer_Grund_Enum,
                                    FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                    RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                    CursorExtern       => True,
                                    EigeneRasseExtern  => RasseExtern,
                                    RasseExtern        => StadtKonstanten.LeerRasse);

      else
         FarbgebungTerminal.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                    VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                    WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                    GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell),
                                    FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                    RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                    CursorExtern       => True,
                                    EigeneRasseExtern  => RasseExtern,
                                    RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
   end CursorDarstellung;
   
   
   
   procedure AnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      if
        YAchsenabstraktion < -Stadtumgebungsgröße
        or
          YAchsenabstraktion > Stadtumgebungsgröße
      then
         SchleifeAnsichtUmgebung (YAchseExtern => YAchseExtern,
                                  XAchseExtern => XAchseExtern,
                                  RasseExtern  => StadtRasseNummerExtern.Rasse);

      elsif
        Stadtumgebungsgröße = 1
        and
          YAchseExtern < 3
      then
         SchleifeAnsichtUmgebung (YAchseExtern => YAchseExtern,
                                  XAchseExtern => XAchseExtern,
                                  RasseExtern  => StadtRasseNummerExtern.Rasse);

      elsif
        Stadtumgebungsgröße = 2
        and
          YAchseExtern < 2
      then
         SchleifeAnsichtUmgebung (YAchseExtern => YAchseExtern,
                                  XAchseExtern => XAchseExtern,
                                  RasseExtern  => StadtRasseNummerExtern.Rasse);
                  
      else
         AnzeigeStadtUmgebung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               YAchseExtern           => YAchseExtern,
                               XAchseExtern           => XAchseExtern);
      end if;
      
   end AnsichtUmgebung;



   procedure SchleifeAnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Hier muss nur von 0 .. 6 geloopt werden, da aber Stadtfeld nur von 1 .. 20 geht, wird eins weiter geloopt und im if eins abgezogen
      UmgebungSchleife:
      for UmgebungSchleifenwert in KartenDatentypen.Stadtfeld (1) .. 7 loop
                     
         if
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt = (YAchseExtern, XAchseExtern + UmgebungSchleifenwert - 1)
         then
            FarbgebungTerminal.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                       VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                       WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                       GrundExtern        => KartengrundDatentypen.Leer_Grund_Enum,
                                       FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                       RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                       CursorExtern       => True,
                                       EigeneRasseExtern  => RasseExtern,
                                       RasseExtern        => StadtKonstanten.LeerRasse);

         else
            Put (Item => TextKonstanten.LeerZeichen);
         end if;
                     
      end loop UmgebungSchleife;
      
      New_Line;
      
   end SchleifeAnsichtUmgebung;



   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld)
   is begin
      
      UmgebungsSchleife:
      for UmgebungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop

         Cursor := CursorKonstant + UmgebungSchleifenwert;
         if
           SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt = (YAchseExtern, XAchseExtern + Cursor)
         then
            AnzeigeUmgebungCursor (RasseExtern    => StadtRasseNummerExtern.Rasse,
                                   UmgebungExtern => UmgebungSchleifenwert);
                           
         elsif
           UmgebungSchleifenwert < -Stadtumgebungsgröße
           or
             UmgebungSchleifenwert > Stadtumgebungsgröße
         then
            Put (Item => TextKonstanten.LeerZeichen);

         else            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell,
                                                                                                 ÄnderungExtern    => (0, YAchsenabstraktion, UmgebungSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  Put (Item => TextKonstanten.LeerZeichen);

               when others =>
                  GrafischeAnzeigeTerminal.Sichtbarkeit (InDerStadtExtern  => True,
                                                        KoordinatenExtern => KartenWert,
                                                        RasseExtern       => StadtRasseNummerExtern.Rasse);
            end case;
         end if;

      end loop UmgebungsSchleife;

      New_Line;
      YAchsenabstraktion := YAchsenabstraktion + 1;
      
   end AnzeigeStadtUmgebung;
   
   
   
   procedure AnzeigeUmgebungCursor
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in KartenDatentypen.UmgebungsbereichDrei)
   is begin
      
      if
        UmgebungExtern < -Stadtumgebungsgröße
        or
          UmgebungExtern > Stadtumgebungsgröße
      then
         FarbgebungTerminal.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                    VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                    WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                    GrundExtern        => KartengrundDatentypen.Leer_Grund_Enum,
                                    FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                    RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                    CursorExtern       => True,
                                    EigeneRasseExtern  => RasseExtern,
                                    RasseExtern        => StadtKonstanten.LeerRasse);

      else
         InformationenStadtAufrufen := True;
         CursorYAchseabstraktion := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse - 4;
         CursorXAchseabstraktion := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse - 17;
               
         KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                                              ÄnderungExtern    => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                                                              LogikGrafikExtern => False);
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               FarbgebungTerminal.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                          VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                          WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                          GrundExtern        => KartengrundDatentypen.Leer_Grund_Enum,
                                          FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                          RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                          CursorExtern       => True,
                                          EigeneRasseExtern  => RasseExtern,
                                          RasseExtern        => StadtKonstanten.LeerRasse);

            when others =>
               FarbgebungTerminal.Farben  (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                          VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                          WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                          GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert),
                                          FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                          RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                          CursorExtern       => True,
                                          EigeneRasseExtern  => RasseExtern,
                                          RasseExtern        => StadtKonstanten.LeerRasse);
         end case;
      end if;
      
   end AnzeigeUmgebungCursor;
   
   
   
   procedure WeitereInformationen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin

      CursorYAchseabstraktion := SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse - 4;
      CursorXAchseabstraktion := SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse - 17;
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell,
                                                                                           ÄnderungExtern    => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                                                           LogikGrafikExtern => False);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;

         when others =>
            null;
      end case;
      
      case
        LeseKarten.BasisGrund (KoordinatenExtern => KartenWert)
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            null;
         
         when others =>
            -- TextAnzeigeTerminal.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
            --                                           TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
            --                                           ÜberschriftZeileExtern => 0,
            --                                           ErsteZeileExtern       => 34,
            --                                           LetzteZeileExtern      => 34,
            --                                           AbstandAnfangExtern    => GlobaleTexte.Leer,
            --                                           AbstandMitteExtern     => GlobaleTexte.Leer,
            --                                           AbstandEndeExtern      => GlobaleTexte.Leer);
            null;
      end case;
      
      -- Hier sollte eine Überprüfung ob der Grund nicht Leer ist nicht nötig sein, da weiter oben bereits geprüft wir ob das eine gültige Koordinate ist.
      Put (Item => KartenAllgemein.BeschreibungZusatzgrund (KartenGrundExtern => LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert)));
      
      StadtInformationenTerminal.EinzelnesFeldNahrungsgewinnung (KoordinatenExtern => KartenWert,
                                                                RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenTerminal.EinzelnesFeldRessourcengewinnung (KoordinatenExtern => KartenWert,
                                                                  RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenTerminal.EinzelnesFeldGeldgewinnung (KoordinatenExtern => KartenWert,
                                                            RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenTerminal.EinzelnesFeldWissensgewinnung (KoordinatenExtern => KartenWert,
                                                               RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationenTerminal.StadtfeldBewirtschaftet (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         CursorYAchseabstraktionExtern => CursorYAchseabstraktion,
                                                         CursorXAchseabstraktionExtern => CursorXAchseabstraktion);
      
   end WeitereInformationen;

end KarteStadtTerminal;
