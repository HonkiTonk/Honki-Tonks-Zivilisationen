pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenRecords; use KartenRecords;
with GlobaleTexte;
with KartenKonstanten;
with SystemKonstanten;
with StadtKonstanten;

with LeseKarten;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with KartePositionPruefen;
with Karten;
with StadtInformationen;
with Anzeige;
with GebaeudeAllgemein;
with KartenAllgemein;
with GrafischeAnzeige;
with Farbgebung;

package body KarteStadtKonsole is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      InformationenStadtAufrufen := False;

      GrafischeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtInformationen.Stadt (RasseExtern            => StadtRasseNummerExtern.Rasse,
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
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Aufschlag := AufschlagGebäude (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      case
        Aufschlag
      is
         when KartenDatentypen.SichtweiteMitNullwert'First =>
            null;
            
         when others =>
            Aufschlag := Aufschlag - 1;
            if
              LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 WelchesGebäudeExtern  => EinheitStadtDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse + Aufschlag * 12))
              = True
            then
               Put_Line (Item => GebaeudeAllgemein.BeschreibungKurz (IDExtern => EinheitStadtDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse + Aufschlag * 12)));
            
            else
               null;
            end if;
      end case;

      New_Line;
      
   end GebäudeText;
   
   
   
   function AufschlagGebäude
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteMitNullwert
   is begin
      
      if
        ((GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse = 1
          or
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse = 2)
         and
           GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse <= 12)
        or
          (GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse = 3
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse <= 2)
      then
         return GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse;
         
      else
         return KartenDatentypen.SichtweiteMitNullwert'First;
      end if;
      
   end AufschlagGebäude;
     
   
   
   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt = (YAchseExtern, XAchseExtern)
      then
         CursorDarstellung (YAchseExtern => YAchseExtern,
                            XAchseExtern => XAchseExtern,
                            RasseExtern  => StadtRasseNummerExtern.Rasse);

      elsif
        YAchseExtern < Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern = Karten.Stadtkarte'Last (2) - 7
      then
         Put (Item => SystemKonstanten.LeerZeichen);

      elsif
        YAchseExtern = Karten.Stadtkarte'First (1) + 7
        and
          XAchseExtern >= Karten.Stadtkarte'Last (2) - 7
      then
         Put (Item => SystemKonstanten.LeerZeichen);

      elsif
        YAchseExtern = 1
        and
          XAchseExtern < 13
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => EinheitStadtDatentypen.GebäudeID (XAchseExtern));
               
      elsif
        YAchseExtern = 2
        and
          XAchseExtern < 13
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => EinheitStadtDatentypen.GebäudeID (XAchseExtern) + 12);
               
      elsif
        YAchseExtern = 3
        and
          XAchseExtern < 3
      then
         GebäudeDarstellung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                              IDExtern               => EinheitStadtDatentypen.GebäudeID (XAchseExtern) + 24);

      else
         Farbgebung.Farben (EinheitIDExtern    => 0,
                            VerbesserungExtern => KartenDatentypen.Leer,
                            RessourceExtern    => KartenDatentypen.Leer,
                            GrundExtern        => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position),
                            CursorExtern       => False,
                            EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                            RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
      return False;
      
   end Darstellung;
   
   
   
   procedure GebäudeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
   is begin
      
      if
        LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                           WelchesGebäudeExtern  => IDExtern)
        = True
      then
         Put (Item => LeseGebaeudeDatenbank.GebäudeGrafik (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                            IDExtern    => IDExtern));

      else
         Farbgebung.Farben (EinheitIDExtern    => 0,
                            VerbesserungExtern => KartenDatentypen.Leer,
                            RessourceExtern    => KartenDatentypen.Leer,
                            GrundExtern        => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position),
                            CursorExtern       => False,
                            EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                            RasseExtern        => StadtKonstanten.LeerRasse);
      end if;
      
   end GebäudeDarstellung;
   
   
   
   procedure CursorDarstellung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
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
         Farbgebung.Farben (EinheitIDExtern    => 0,
                            VerbesserungExtern => KartenDatentypen.Leer,
                            RessourceExtern    => KartenDatentypen.Leer,
                            GrundExtern        => KartenDatentypen.Leer,
                            CursorExtern       => True,
                            EigeneRasseExtern  => RasseExtern,
                            RasseExtern        => StadtKonstanten.LeerRasse);

      else
         Farbgebung.Farben (EinheitIDExtern    => 0,
                            VerbesserungExtern => KartenDatentypen.Leer,
                            RessourceExtern    => KartenDatentypen.Leer,
                            GrundExtern        => LeseKarten.Grund (PositionExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position),
                            CursorExtern       => True,
                            EigeneRasseExtern  => RasseExtern,
                            RasseExtern        => StadtKonstanten.LeerRasse);

      end if;
      
   end CursorDarstellung;
   
   
   
   procedure AnsichtUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Hier muss nur von 0 .. 6 geloopt werden, da aber Stadtfeld nur von 1 .. 20 geht, wird eins weiter geloopt und im if eins abgezogen
      UmgebungSchleife:
      for UmgebungSchleifenwert in KartenDatentypen.Stadtfeld (1) .. 7 loop
                     
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt = (YAchseExtern, XAchseExtern + UmgebungSchleifenwert - 1)
         then
            Farbgebung.Farben (EinheitIDExtern    => 0,
                               VerbesserungExtern => KartenDatentypen.Leer,
                               RessourceExtern    => KartenDatentypen.Leer,
                               GrundExtern        => KartenDatentypen.Leer,
                               CursorExtern       => True,
                               EigeneRasseExtern  => RasseExtern,
                               RasseExtern        => StadtKonstanten.LeerRasse);

         else
            Put (Item => SystemKonstanten.LeerZeichen);
         end if;
                     
      end loop UmgebungSchleife;
      
      New_Line;
      
   end SchleifeAnsichtUmgebung;



   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld)
   is begin
      
      UmgebungsSchleife:
      for UmgebungSchleifenwert in KartenDatentypen.LoopRangeMinusDreiZuDrei'Range loop

         Cursor := CursorKonstant + UmgebungSchleifenwert;
         if
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt = (YAchseExtern, XAchseExtern + Cursor)
         then
            AnzeigeUmgebungCursor (RasseExtern    => StadtRasseNummerExtern.Rasse,
                                   UmgebungExtern => UmgebungSchleifenwert);
                           
         elsif
           UmgebungSchleifenwert < -Stadtumgebungsgröße
           or
             UmgebungSchleifenwert > Stadtumgebungsgröße
         then
            Put (Item => SystemKonstanten.LeerZeichen);

         else            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position,
                                                                        ÄnderungExtern    => (0, YAchsenabstraktion, UmgebungSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  Put (Item => SystemKonstanten.LeerZeichen);

               when others =>
                  GrafischeAnzeige.Sichtbarkeit (InDerStadtExtern  => True,
                                                 KoordinatenExtern => KartenWert,
                                                 RasseExtern       => StadtRasseNummerExtern.Rasse);
            end case;
         end if;

      end loop UmgebungsSchleife;

      New_Line;
      YAchsenabstraktion := YAchsenabstraktion + 1;
      
   end AnzeigeStadtUmgebung;
   
   
   
   procedure AnzeigeUmgebungCursor
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei)
   is begin
      
      if
        UmgebungExtern < -Stadtumgebungsgröße
        or
          UmgebungExtern > Stadtumgebungsgröße
      then
         Farbgebung.Farben (EinheitIDExtern    => 0,
                            VerbesserungExtern => KartenDatentypen.Leer,
                            RessourceExtern    => KartenDatentypen.Leer,
                            GrundExtern        => KartenDatentypen.Leer,
                            CursorExtern       => True,
                            EigeneRasseExtern  => RasseExtern,
                            RasseExtern        => StadtKonstanten.LeerRasse);

      else
         InformationenStadtAufrufen := True;
         CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse - 4;
         CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse - 17;
               
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                     ÄnderungExtern    => (0, CursorYAchseabstraktion, CursorXAchseabstraktion));
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               Farbgebung.Farben (EinheitIDExtern    => 0,
                                  VerbesserungExtern => KartenDatentypen.Leer,
                                  RessourceExtern    => KartenDatentypen.Leer,
                                  GrundExtern        => KartenDatentypen.Leer,
                                  CursorExtern       => True,
                                  EigeneRasseExtern  => RasseExtern,
                                  RasseExtern        => StadtKonstanten.LeerRasse);

            when others =>
               Farbgebung.Farben (EinheitIDExtern    => 0,
                                  VerbesserungExtern => KartenDatentypen.Leer,
                                  RessourceExtern    => KartenDatentypen.Leer,
                                  GrundExtern        => LeseKarten.Grund (PositionExtern => KartenWert),
                                  CursorExtern       => True,
                                  EigeneRasseExtern  => RasseExtern,
                                  RasseExtern        => StadtKonstanten.LeerRasse);
         end case;
      end if;
      
   end AnzeigeUmgebungCursor;
   
   
   
   procedure WeitereInformationen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin

      CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse - 4;
      CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse - 17;
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position,
                                                                  ÄnderungExtern    => (0, CursorYAchseabstraktion, CursorXAchseabstraktion));
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;

         when others =>
            null;
      end case;
      
      if
        LeseKarten.Hügel (PositionExtern => KartenWert) = True
      then
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 34,
                                        LetzteZeileExtern      => 34,
                                        AbstandAnfangExtern    => GlobaleTexte.Leer,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Leer);
         
      else
         null;
      end if;
      
      Put (Item => KartenAllgemein.Beschreibung (KartenGrundExtern => LeseKarten.Grund (PositionExtern => KartenWert)));
      StadtInformationen.EinzelnesFeldNahrungsgewinnung (KoordinatenExtern => KartenWert,
                                                         RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationen.EinzelnesFeldRessourcengewinnung (KoordinatenExtern => KartenWert,
                                                           RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationen.EinzelnesFeldGeldgewinnung (KoordinatenExtern => KartenWert,
                                                     RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationen.EinzelnesFeldWissensgewinnung (KoordinatenExtern => KartenWert,
                                                        RasseExtern       => StadtRasseNummerExtern.Rasse);
      StadtInformationen.StadtfeldBewirtschaftet (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                  CursorYAchseabstraktionExtern => CursorYAchseabstraktion,
                                                  CursorXAchseabstraktionExtern => CursorXAchseabstraktion);
      
   end WeitereInformationen;

end KarteStadtKonsole;
