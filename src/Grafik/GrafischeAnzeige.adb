pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten;

with LeseKarten, LeseEinheitenGebaut, LeseStadtGebaut;

with EinheitSuchen, StadtSuchen, Farbgebung;

package body GrafischeAnzeige is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
             
      case
        LeseKarten.Sichtbar (PositionExtern => KoordinatenExtern,
                             RasseExtern    => RasseExtern)
      is
         when True =>
            IstSichtbar (InDerStadtExtern  => InDerStadtExtern,
                         KoordinatenExtern => KoordinatenExtern,
                         RasseExtern       => RasseExtern);
            
         when False =>
            if
              KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
            then         
               Farbgebung.Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                                  VerbesserungExtern       => GlobaleDatentypen.Leer,
                                  RessourceExtern          => GlobaleDatentypen.Leer,
                                  GrundExtern              => GlobaleDatentypen.Leer,
                                  CursorExtern             => True,
                                  EigeneRasseExtern        => RasseExtern,
                                  RasseExtern              => GlobaleDatentypen.Leer);
               
            else
               Put (Item => GlobaleKonstanten.NichtSichtbar);
            end if;
      end case;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen.
      -- Über den Kartenressourcen kommen die Kartenverbesserungen.
      -- Über die Kartenverbesserungen kommen die Städte.
      -- Über die Städte kommen die nicht Transporteinheiten.
      -- Über den nicht Transporteinheiten kommen die Transporteinheiten.
      -- Über den Transporteinheiten kommt der Cursor.
      
      case
        AnzeigeCursor (InDerStadtExtern  => InDerStadtExtern,
                       KoordinatenExtern => KoordinatenExtern,
                       RasseExtern       => RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;
      
      case
        AnzeigeEinheit (KoordinatenExtern => KoordinatenExtern,
                        RasseExtern       => RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;
         
      case
        AnzeigeStadt (KoordinatenExtern => KoordinatenExtern,
                      RasseExtern       => RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;

      AnzeigeLandschaft (KoordinatenExtern => KoordinatenExtern,
                         RasseExtern       => RasseExtern);
      
   end IstSichtbar;
   
   
   
   function AnzeigeCursor
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
        and
          InDerStadtExtern = False
      then
         Farbgebung.Farben (EinheitIDExtern          => 0,
                            VerbesserungExtern       => GlobaleDatentypen.Leer,
                            RessourceExtern          => GlobaleDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => True,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => GlobaleDatentypen.Leer);
         return True;
         
      else
         return False;
      end if;
      
   end AnzeigeCursor;
   
   
   
   function AnzeigeEinheit
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      EinheitStadtRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return False;
            
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer) /= GlobaleKonstanten.LeerTransportiertWirdTransportiert
      then
         Farbgebung.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitStadtRasseNummer.Rasse,
                                                                                                       LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer))),
                            VerbesserungExtern => GlobaleDatentypen.Leer,
                            RessourceExtern    => GlobaleDatentypen.Leer,
                            GrundExtern        => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern       => False,
                            EigeneRasseExtern  => RasseExtern,
                            RasseExtern        => EinheitStadtRasseNummer.Rasse);
         return True;
            
      else
         Farbgebung.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitStadtRasseNummer),
                            VerbesserungExtern => GlobaleDatentypen.Leer,
                            RessourceExtern    => GlobaleDatentypen.Leer,
                            GrundExtern        => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern       => False,
                            EigeneRasseExtern  => RasseExtern,
                            RasseExtern        => EinheitStadtRasseNummer.Rasse);
         return True;
      end if;
      
   end AnzeigeEinheit;
   
   
   
   function AnzeigeStadt
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return False;
            
      else
         Farbgebung.Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                            VerbesserungExtern       => LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer),
                            RessourceExtern          => GlobaleDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitStadtRasseNummer.Rasse);
         return True;
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
      then            
         Farbgebung.Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                            VerbesserungExtern       => LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern),
                            RessourceExtern          => GlobaleDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => GlobaleDatentypen.Leer);
           
      elsif
        LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
      then
         Farbgebung.Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                            VerbesserungExtern       => LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern),
                            RessourceExtern          => GlobaleDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => GlobaleDatentypen.Leer);
            
      elsif
        LeseKarten.Ressource (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
      then
         Farbgebung.Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                            VerbesserungExtern       => GlobaleDatentypen.Leer,
                            RessourceExtern          => LeseKarten.Ressource (PositionExtern => KoordinatenExtern),
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => GlobaleDatentypen.Leer);
            
      elsif
        LeseKarten.Fluss (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Leer
      then
         Farbgebung.Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                            VerbesserungExtern       => GlobaleDatentypen.Leer,
                            RessourceExtern          => LeseKarten.Fluss (PositionExtern => KoordinatenExtern),
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => GlobaleDatentypen.Leer);
            
      else
         Farbgebung.Farben (EinheitIDExtern          => GlobaleKonstanten.LeerEinheitenID,
                            VerbesserungExtern       => GlobaleDatentypen.Leer,
                            RessourceExtern          => GlobaleDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => GlobaleDatentypen.Leer);
      end if;
      
   end AnzeigeLandschaft;

end GrafischeAnzeige;
