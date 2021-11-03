pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;
with SystemKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with EinheitSuchen;
with StadtSuchen;
with Farbgebung;

package body GrafischeAnzeige is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
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
               Farbgebung.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                  VerbesserungExtern       => KartenDatentypen.Leer,
                                  RessourceExtern          => KartenDatentypen.Leer,
                                  GrundExtern              => KartenDatentypen.Leer,
                                  CursorExtern             => True,
                                  EigeneRasseExtern        => RasseExtern,
                                  RasseExtern              => EinheitenKonstanten.LeerRasse);
               
            else
               Put (Item => SystemKonstanten.LeerZeichen);
            end if;
      end case;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
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
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
        and
          InDerStadtExtern = False
      then
         Farbgebung.Farben (EinheitIDExtern          => 0,
                            VerbesserungExtern       => KartenDatentypen.Leer,
                            RessourceExtern          => KartenDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => True,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitenKonstanten.LeerRasse);
         return True;
         
      else
         return False;
      end if;
      
   end AnzeigeCursor;
   
   
   
   function AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      EinheitStadtRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         return False;
            
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         Farbgebung.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitStadtRasseNummer.Rasse,
                                                                                                       LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer))),
                            VerbesserungExtern => KartenDatentypen.Leer,
                            RessourceExtern    => KartenDatentypen.Leer,
                            GrundExtern        => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern       => False,
                            EigeneRasseExtern  => RasseExtern,
                            RasseExtern        => EinheitStadtRasseNummer.Rasse);
         return True;
            
      else
         Farbgebung.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitStadtRasseNummer),
                            VerbesserungExtern => KartenDatentypen.Leer,
                            RessourceExtern    => KartenDatentypen.Leer,
                            GrundExtern        => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern       => False,
                            EigeneRasseExtern  => RasseExtern,
                            RasseExtern        => EinheitStadtRasseNummer.Rasse);
         return True;
      end if;
      
   end AnzeigeEinheit;
   
   
   
   function AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         return False;
            
      else
         Farbgebung.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                            VerbesserungExtern       => LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer),
                            RessourceExtern          => KartenDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitStadtRasseNummer.Rasse);
         return True;
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern) /= KartenDatentypen.Leer
      then
         Farbgebung.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                            VerbesserungExtern       => LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern),
                            RessourceExtern          => KartenDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitenKonstanten.LeerRasse);
           
      elsif
        LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern) /= KartenDatentypen.Leer
      then
         Farbgebung.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                            VerbesserungExtern       => LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern),
                            RessourceExtern          => KartenDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Ressource (PositionExtern => KoordinatenExtern) /= KartenDatentypen.Leer
      then
         Farbgebung.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                            VerbesserungExtern       => KartenDatentypen.Leer,
                            RessourceExtern          => LeseKarten.Ressource (PositionExtern => KoordinatenExtern),
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Fluss (PositionExtern => KoordinatenExtern) /= KartenDatentypen.Leer
      then
         Farbgebung.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                            VerbesserungExtern       => KartenDatentypen.Leer,
                            RessourceExtern          => LeseKarten.Fluss (PositionExtern => KoordinatenExtern),
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitenKonstanten.LeerRasse);
            
      else
         Farbgebung.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                            VerbesserungExtern       => KartenDatentypen.Leer,
                            RessourceExtern          => KartenDatentypen.Leer,
                            GrundExtern              => LeseKarten.Grund (PositionExtern => KoordinatenExtern),
                            CursorExtern             => False,
                            EigeneRasseExtern        => RasseExtern,
                            RasseExtern              => EinheitenKonstanten.LeerRasse);
      end if;
      
   end AnzeigeLandschaft;

end GrafischeAnzeige;
