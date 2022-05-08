pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with EinheitenKonstanten;
with TextKonstanten;
with SpielVariablen;

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
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
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
              KoordinatenExtern = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell
            then
               FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                         VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                         WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                         GrundExtern        => KartengrundDatentypen.Leer_Grund_Enum,
                                         FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                         RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                         CursorExtern       => True,
                                         EigeneRasseExtern  => RasseExtern,
                                         RasseExtern        => EinheitenKonstanten.LeerRasse);
               
            else
               Put (Item => TextKonstanten.LeerZeichen);
            end if;
      end case;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenflüssen.
      -- Über den Kartenflüssen kommen die Kartenressourcen.
      -- Über den Kartenressourcen kommen die Straßen und dann die Verbesserungen (eventuell anders herum? Dann könnte man die Straßen sehen und einfacher die Einheit bewegen). --------------------------
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
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        KoordinatenExtern = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell
        and
          InDerStadtExtern = False
      then
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => True,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
         return True;
         
      else
         return False;
      end if;
      
   end AnzeigeCursor;
   
   
   
   function AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      EinheitStadtRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return False;
            
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         FarbgebungKonsole.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitStadtRasseNummer.Rasse,
                                                                                                              LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer))),
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitStadtRasseNummer.Rasse);
         
      else
         FarbgebungKonsole.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitStadtRasseNummer),
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitStadtRasseNummer.Rasse);
      end if;
      
      return True;
      
   end AnzeigeEinheit;
   
   
   
   function AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return False;
            
      else
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer),
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitStadtRasseNummer.Rasse);
         return True;
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -------------------------- Mal hier aufteilen damit die Abfragen hier nicht doppelt stattfinden.
      if
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern),
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
         
      elsif
        LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern),
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern) /= KartengrundDatentypen.Leer_Ressource_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern) /= KartengrundDatentypen.Leer_Fluss_Enum
      then
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
            
      else
         FarbgebungKonsole.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.Grund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
      end if;
      
   end AnzeigeLandschaft;

end GrafischeAnzeigeKonsole;
