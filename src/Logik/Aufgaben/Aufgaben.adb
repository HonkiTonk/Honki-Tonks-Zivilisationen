pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;
with KartenKonstanten;

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
with VerbesserungWeg;
with VerbesserungMine;
with VerbesserungRoden;
with VerbesserungFarm;
with VerbesserungFestung;
with VerbesserungWald;
with AufgabenAllgemein;

package body Aufgaben is
   
   function VerbesserungTesten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum)
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum)
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
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = SystemKonstanten.LeerTastenbelegungKonstante
        or
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      if
        ForschungKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern) = -1
      then
         return False;

      elsif
        ForschungKonstanten.TechnologieVerbesserung (EinheitRasseNummerExtern.Rasse, BefehlExtern) = 0
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
        BefehlExtern in SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            /= EinheitStadtDatentypen.Arbeiter
      then
         return False;
         
      elsif
        BefehlExtern = SystemKonstanten.PlündernKonstante
        and
          LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
            = EinheitStadtDatentypen.Arbeiter
      then
         return False;
         
      else
         null;
      end if;
      
      return True;
      
   end AllgemeinerAnfangstest;
   


   function VerbesserungFestgelegt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Grund := LeseKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        BefehlExtern
      is
         when SystemKonstanten.StraßeBauenKonstante =>
            return VerbesserungWeg.VerbesserungWeg (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    GrundExtern              => Grund,
                                                    AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when SystemKonstanten.MineBauenKonstante =>
            return VerbesserungMine.VerbesserungMine (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when SystemKonstanten.FarmBauenKonstante =>
            return VerbesserungFarm.VerbesserungFarm (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when SystemKonstanten.FestungBauenKonstante =>
            return VerbesserungFestung.VerbesserungFestung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            GrundExtern              => Grund,
                                                            AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when SystemKonstanten.WaldAufforstenKonstante =>
            return VerbesserungWald.VerbesserungWald (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      GrundExtern              => Grund,
                                                      AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when SystemKonstanten.RodenTrockenlegenKonstante =>
            return VerbesserungRoden.VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        GrundExtern              => Grund,
                                                        AnlegenTestenExtern      => AnlegenTestenExtern);
         
         when SystemKonstanten.HeilenKonstante =>
            return EinheitHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                  AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when SystemKonstanten.VerschanzenKonstante =>
            EinheitVerschanzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when SystemKonstanten.RundeAussetzenKonstante =>
            RundeAussetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when SystemKonstanten.AuflösenKonstante =>
            EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when SystemKonstanten.PlündernKonstante =>
            if
              LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) /= KartenKonstanten.LeerVerbesserungGebiet
              or
                LeseKarten.VerbesserungWeg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) /= KartenKonstanten.LeerVerbesserungWeg
            then
               return VerbesserungPlündern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             AnlegenTestenExtern      => AnlegenTestenExtern);
               
            else
               return False;
            end if;
         
         when SystemKonstanten.EinheitVerbessernKonstante =>
            return VerbesserungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        AnlegenTestenExtern      => AnlegenTestenExtern);
      end case;
      
      return True;
      
   end VerbesserungFestgelegt;
   
   
   
   function EinheitHeilen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
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
                                                 BeschäftigungExtern     => SystemKonstanten.HeilenKonstante);
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => SystemKonstanten.LeerTastenbelegungKonstante);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                                         RechnenSetzenExtern      => 0);
      end case;
      
      return True;
      
   end EinheitHeilen;
   
   
   
   procedure EinheitVerschanzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => SystemKonstanten.VerschanzenKonstante);
      
   end EinheitVerschanzen;
   
   
   
   procedure RundeAussetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                               RechnenSetzenExtern      => 0);
      
   end RundeAussetzen;
   
   
   
   procedure EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.SpielerMenschKonstante
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
            
      if
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenKonstanten.LeerVerbesserungGebiet
        and
          LeseKarten.VerbesserungWeg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenKonstanten.LeerVerbesserungWeg
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
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.SpielerMenschKonstante
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenKonstanten.LeerVerbesserungGebiet =>
            null;
            
         when others =>
            SchreibeKarten.VerbesserungGebiet (KoordinatenExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                               VerbesserungExtern => KartenKonstanten.LeerVerbesserungGebiet);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 10,
                                         RechnenSetzenExtern => True);
      end case;
      
      case
        LeseKarten.VerbesserungWeg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenKonstanten.LeerVerbesserungWeg =>
            null;
            
         when others =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            WegExtern         => KartenKonstanten.LeerVerbesserungWeg);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 5,
                                         RechnenSetzenExtern => True);
      end case;
      
   end Plünderung;
   
   
   
   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
