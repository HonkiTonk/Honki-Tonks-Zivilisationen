pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with EinheitenKonstanten;
with SystemKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with EinheitSuchen;
with StadtSuchen;
with FarbgebungKonsole;

package body GrafischeAnzeigeKonsole is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
             
      case
        LeseKarten.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            IstSichtbar (InDerStadtExtern  => InDerStadtExtern,
                         KoordinatenExtern => KoordinatenExtern,
                         RasseExtern       => RasseExtern);
            
         when False =>
            if
              KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell
            then
               FarbgebungKonsole.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                         VerbesserungExtern       => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                         RessourceExtern          => KartenGrundDatentypen.Leer_Ressource_Enum,
                                         GrundExtern              => KartenGrundDatentypen.Leer_Grund_Enum,
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
        KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell
        and
          InDerStadtExtern = False
      then
         FarbgebungKonsole.Farben (EinheitIDExtern          => 0,
                                   VerbesserungExtern       => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   RessourceExtern          => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   GrundExtern              => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
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
         FarbgebungKonsole.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitStadtRasseNummer.Rasse,
                                                                                                              LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer))),
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitStadtRasseNummer.Rasse);
         return True;
            
      else
         FarbgebungKonsole.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitStadtRasseNummer),
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   RessourceExtern    => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
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
         FarbgebungKonsole.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern       => LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer),
                                   RessourceExtern          => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   GrundExtern              => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
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
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern       => LeseKarten.VerbesserungGebiet (KoordinatenExtern => KoordinatenExtern),
                                   RessourceExtern          => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   GrundExtern              => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern             => False,
                                   EigeneRasseExtern        => RasseExtern,
                                   RasseExtern              => EinheitenKonstanten.LeerRasse);
           
      elsif
        LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern       => LeseKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern),
                                   RessourceExtern          => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   GrundExtern              => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern             => False,
                                   EigeneRasseExtern        => RasseExtern,
                                   RasseExtern              => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern) /= KartenGrundDatentypen.Leer_Ressource_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern       => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   RessourceExtern          => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                   GrundExtern              => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern             => False,
                                   EigeneRasseExtern        => RasseExtern,
                                   RasseExtern              => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern) /= KartenGrundDatentypen.Leer_Fluss_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern       => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   RessourceExtern          => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                   GrundExtern              => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern             => False,
                                   EigeneRasseExtern        => RasseExtern,
                                   RasseExtern              => EinheitenKonstanten.LeerRasse);
            
      else
         FarbgebungKonsole.Farben (EinheitIDExtern          => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern       => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   RessourceExtern          => KartenGrundDatentypen.Leer_Ressource_Enum,
                                   GrundExtern              => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern             => False,
                                   EigeneRasseExtern        => RasseExtern,
                                   RasseExtern              => EinheitenKonstanten.LeerRasse);
      end if;
      
   end AnzeigeLandschaft;

end GrafischeAnzeigeKonsole;
