pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;

with SchreibeKarten;
with SchreibeEinheitenGebaut;
with SchreibeWichtiges;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWichtiges;

with EinheitenBeschreibungen;
with EinheitenErzeugenEntfernen;
with EinheitenModifizieren;
with WegErmitteln;
with MineErmitteln;
with RodenErmitteln;
with FarmErmitteln;
with FestungErmitteln;
with WaldErmitteln;
with AufgabenAllgemein;

------------------------ Das hier auch mal besser aufteilen.
package body Aufgaben is
   
   function VerbesserungTesten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      case
        AllgemeinerAnfangstest (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                BefehlExtern             => BefehlExtern)
      is
         when True =>
            return VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => BefehlExtern,
                                           AnlegenTestenExtern      => False);
            
         when False =>
            return False;
      end case;
      
   end VerbesserungTesten;
   
   
   
   function VerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      case
        AllgemeinerAnfangstest (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                BefehlExtern             => BefehlExtern)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
     
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        or
          SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum
      then
         return VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        BefehlExtern             => BefehlExtern,
                                        AnlegenTestenExtern      => True);
         
      else
         case
           EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 7)
         is
            when True =>
               return VerbesserungFestgelegt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BefehlExtern             => BefehlExtern,
                                              AnlegenTestenExtern      => True);
                     
            when False =>
               return False;
         end case;
      end if;
   
   end VerbesserungAnlegen;
   
   
   
   function AllgemeinerAnfangstest
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      if
        ForschungKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern) = ForschungKonstanten.ForschungUnmöglich
      then
         return False;

      elsif
        ForschungKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern) = ForschungKonstanten.LeerForschung
      then
         null;

      elsif
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern => ForschungKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern))
          = True
      then
         null;
         
      else
         return False;
      end if;
      
      if
        BefehlExtern in TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            /= EinheitStadtDatentypen.Arbeiter_Enum
      then
         return False;
         
      elsif
        BefehlExtern = TastenbelegungDatentypen.Plündern_Enum
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            = EinheitStadtDatentypen.Arbeiter_Enum
      then
         return False;
         
      else
         null;
      end if;
      
      return True;
      
   end AllgemeinerAnfangstest;
   


   function VerbesserungFestgelegt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Grund := LeseKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Straße_Bauen_Enum =>
            return WegErmitteln.WegErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    GrundExtern              => Grund,
                                                    AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when TastenbelegungDatentypen.Mine_Bauen_Enum =>
            return MineErmitteln.MineErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when TastenbelegungDatentypen.Farm_Bauen_Enum =>
            return FarmErmitteln.FarmErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when TastenbelegungDatentypen.Festung_Bauen_Enum =>
            return FestungErmitteln.FestungErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            GrundExtern              => Grund,
                                                            AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when TastenbelegungDatentypen.Wald_Aufforsten_Enum =>
            return WaldErmitteln.WaldErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when TastenbelegungDatentypen.Roden_Trockenlegen_Enum =>
            return RodenErmitteln.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        GrundExtern              => Grund,
                                                        AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when TastenbelegungDatentypen.Heilen_Enum =>
            return EinheitHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when TastenbelegungDatentypen.Verschanzen_Enum =>
            EinheitVerschanzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when TastenbelegungDatentypen.Runde_Aussetzen_Enum =>
            RundeAussetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when TastenbelegungDatentypen.Auflösen_Enum =>
            EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when TastenbelegungDatentypen.Plündern_Enum =>
            if
              LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) /= KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
              or
                LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) /= KartenVerbesserungDatentypen.Leer_Weg_Enum
            then
               return VerbesserungPlündern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             AnlegenTestenExtern      => AnlegenTestenExtern);
               
            else
               return False;
            end if;
         
         when TastenbelegungDatentypen.Einheit_Verbessern_Enum =>
            return VerbesserungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        AnlegenTestenExtern      => AnlegenTestenExtern);
      end case;
      
      return True;
      
   end VerbesserungFestgelegt;
   
   
   
   function EinheitHeilen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        = LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         return False;
         
      else
         SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BeschäftigungExtern     => AufgabenDatentypen.Heilen_Enum);
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end EinheitHeilen;
   
   
   
   procedure EinheitVerschanzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => AufgabenDatentypen.Verschanzen_Enum);
      
   end EinheitVerschanzen;
   
   
   
   procedure RundeAussetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                               RechnenSetzenExtern      => 0);
      
   end RundeAussetzen;
   
   
   
   procedure EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Spieler_Mensch_Enum
      then
         EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      elsif
        EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 9) = True
      then
         EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         null;
      end if;
      
   end EinheitAuflösen;
   
   
   
   function VerbesserungPlündern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
            
      if
        LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
        and
          LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         return False;
         
      elsif
        AnlegenTestenExtern = False
      then
         return True;
         
      else
         null;
      end if;
      
      if
        SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Spieler_Mensch_Enum
      then
         null;
         
      elsif
        EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 12) = True
      then
         null;
                     
      else
         return False;
      end if;
      
      Plünderung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      return True;
      
   end VerbesserungPlündern;
   
   
   
   procedure Plünderung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
            
         when others =>
            SchreibeKarten.Verbesserung (KoordinatenExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                         VerbesserungExtern => KartenVerbesserungDatentypen.Leer_Verbesserung_Enum);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 10,
                                         RechnenSetzenExtern => True);
      end case;
      
      case
        LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            SchreibeKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                WegExtern         => KartenVerbesserungDatentypen.Leer_Weg_Enum);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 5,
                                         RechnenSetzenExtern => True);
      end case;
      
   end Plünderung;
   
   
   
   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern    => IDEinheit)
        = EinheitStadtDatentypen.EinheitenIDMitNullWert'First
        or
          LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                    KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            = False
      then
         return False;
         
      elsif
        LeseWichtiges.Erforscht (RasseExtern             => EinheitRasseNummerExtern.Rasse,
                                 WelcheTechnologieExtern =>  LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                   IDExtern    => LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                                           IDExtern    => IDEinheit)))
        = False
      then
         return False;
         
      else
         null;
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                                    
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;
   
   
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                               RechnenSetzenExtern      => 0);
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     VorzeichenWechselExtern  => -1);
      
      SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  IDExtern                 => LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     VorzeichenWechselExtern  => 1);
      
   end EinheitVerbessern;

end Aufgaben;
