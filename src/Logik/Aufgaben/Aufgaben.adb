pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;
with TextnummernKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseKarten;

with ForschungAllgemein;
with AufgabenAllgemein;
with AufgabeEinheitWeg;
with AufgabeEinheitMine;
with AufgabeEinheitRoden;
with AufgabeEinheitFarm;
with AufgabeEinheitFestung;
with AufgabeEinheitWald;
with AufgabeEinheitHeilen;
with AufgabeEinheitPluendern;
with AufgabeEinheitVerbessern;
with AufgabeEinheitVerschanzen;
with AufgabeEinheitAufloesen;
with UmwandlungenVerschiedeneDatentypen;
with AuswahlLogik;
with MeldungFestlegenLogik;

package body Aufgaben is
   
   function AufgabeTesten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        Anfangstest (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                     EinheitartExtern   => LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                     BefehlExtern       => BefehlExtern,
                     VerbesserungExtern => LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern))
      is
         when True =>
            return AufgabeFestlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => BefehlExtern,
                                     AnlegenTestenExtern      => False,
                                     KoordinatenExtern        => KoordinatenExtern);
            
         when False =>
            return False;
      end case;
      
   end AufgabeTesten;
   
   
   
   function Aufgabe
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        Anfangstest (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                     EinheitartExtern   => LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                     BefehlExtern       => BefehlExtern,
                     VerbesserungExtern => LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern))
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
     
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        and
          SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.KI_Spieler_Enum
      then
         case
           AuswahlLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen)
         is
            when True =>
               null;
               
            when False =>
               return False;
         end case;
         
      else
         null;
      end if;
      
      return AufgabeFestlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               BefehlExtern             => BefehlExtern,
                               AnlegenTestenExtern      => True,
                               KoordinatenExtern        => KoordinatenExtern);
   
   end Aufgabe;
   
   
   
   function Anfangstest
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitartExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum)
      return Boolean
   is begin
      
      if
        BefehlExtern in TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range
        and
          EinheitartExtern /= EinheitenDatentypen.Arbeiter_Enum
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl,
                                                        RasseExtern   => RasseExtern);
         return False;
         
      elsif
        BefehlExtern = TastenbelegungDatentypen.Plündern_Enum
        and
          EinheitartExtern = EinheitenDatentypen.Arbeiter_Enum
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl,
                                                        RasseExtern   => RasseExtern);
         return False;
         
      else
         null;
      end if;
      
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range =>
            if
              False = ForschungAllgemein.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                               TechnologieExtern => ForschungKonstanten.TechnologieVerbesserung (RasseExtern, BefehlExtern))
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserungTechnologie,
                                                              RasseExtern   => RasseExtern);
               return False;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;
      
      -- Das hier immer berücksichtigen bei einer Änderung von Tastenbelegung_Konstruktionen_Enum.
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum'Range =>
            if
              VerbesserungExtern in KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserung,
                                                              RasseExtern   => RasseExtern);
               return False;
               
            elsif
              VerbesserungExtern = UmwandlungenVerschiedeneDatentypen.TastenbelegungNachKartenverbesserung (TasteExtern => BefehlExtern)
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserungExistiert,
                                                              RasseExtern   => RasseExtern);
               return False;
               
            elsif
              (SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 VerbesserungExtern /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum)
              and then
                AuswahlLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLandverbesserungErsetzen) = False
            then
               return False;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;
      
      return True;
                  
   end Anfangstest;
   


   function AufgabeFestlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Straße_Bauen_Enum =>
            return AufgabeEinheitWeg.WegErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern);
         
         when TastenbelegungDatentypen.Mine_Bauen_Enum =>
            return AufgabeEinheitMine.MineErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
            
         when TastenbelegungDatentypen.Farm_Bauen_Enum =>
            return AufgabeEinheitFarm.FarmErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
            
         when TastenbelegungDatentypen.Festung_Bauen_Enum =>
            return AufgabeEinheitFestung.FestungErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           AnlegenTestenExtern      => AnlegenTestenExtern,
                                                           KoordinatenExtern        => KoordinatenExtern);
            
         when TastenbelegungDatentypen.Wald_Aufforsten_Enum =>
            return AufgabeEinheitWald.WaldErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
         
         when TastenbelegungDatentypen.Roden_Trockenlegen_Enum =>
            return AufgabeEinheitRoden.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AnlegenTestenExtern      => AnlegenTestenExtern,
                                                       KoordinatenExtern        => KoordinatenExtern);
         
         when TastenbelegungDatentypen.Heilen_Enum =>
            return AufgabeEinheitHeilen.EinheitHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when TastenbelegungDatentypen.Verschanzen_Enum =>
            return AufgabeEinheitVerschanzen.Verschanzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when TastenbelegungDatentypen.Auflösen_Enum =>
            return AufgabeEinheitAufloesen.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when TastenbelegungDatentypen.Plündern_Enum =>
            return AufgabeEinheitPluendern.VerbesserungPlündern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  AnlegenTestenExtern      => AnlegenTestenExtern,
                                                                  KoordinatenExtern        => KoordinatenExtern);
         
         when TastenbelegungDatentypen.Einheit_Verbessern_Enum =>
            return AufgabeEinheitVerbessern.VerbesserungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 AnlegenTestenExtern      => AnlegenTestenExtern);
      end case;
      
   end AufgabeFestlegen;

end Aufgaben;
