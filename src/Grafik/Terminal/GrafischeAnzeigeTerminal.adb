pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with TextKonstanten;
with StadtKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with EinheitSuchen;
with StadtSuchen;
with FarbgebungTerminal;

package body GrafischeAnzeigeTerminal is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
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
               FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
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
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenflüssen.
      -- Über den Kartenflüssen kommen die Kartenressourcen.
      -- Über den Kartenressourcen kommen die Straßen und dann die Verbesserungen (eventuell anders herum? Dann könnte man die Straßen sehen und einfacher die Einheit bewegen). äöü
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
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        KoordinatenExtern = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell
        and
          InDerStadtExtern = False
      then
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return False;
            
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummer) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         FarbgebungTerminal.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummer.Rasse,
                                                                                                              LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummer))),
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitRasseNummer.Rasse);
         
      else
         FarbgebungTerminal.Farben (EinheitIDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer),
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitRasseNummer.Rasse);
      end if;
      
      return True;
      
   end AnzeigeEinheit;
   
   
   
   function AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        StadtRasseNummer.Nummer = StadtKonstanten.LeerNummer
      then
         return False;
            
      else
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummer),
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => StadtRasseNummer.Rasse);
         return True;
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Mal hier aufteilen damit die Abfragen hier nicht doppelt stattfinden. äöü
      if
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern),
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
         
      elsif
        LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern) /= KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern),
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern) /= KartengrundDatentypen.Leer_Ressource_Enum
      then
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern),
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
            
      elsif
        LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern) /= KartengrundDatentypen.Leer_Fluss_Enum
      then
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern),
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
            
      else
         FarbgebungTerminal.Farben (EinheitIDExtern    => EinheitenKonstanten.LeerID,
                                   VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum,
                                   WegExtern          => KartenVerbesserungDatentypen.Leer_Weg_Enum,
                                   GrundExtern        => LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern),
                                   FlussExtern        => KartengrundDatentypen.Leer_Fluss_Enum,
                                   RessourceExtern    => KartengrundDatentypen.Leer_Ressource_Enum,
                                   CursorExtern       => False,
                                   EigeneRasseExtern  => RasseExtern,
                                   RasseExtern        => EinheitenKonstanten.LeerRasse);
      end if;
      
   end AnzeigeLandschaft;

end GrafischeAnzeigeTerminal;
