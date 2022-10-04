pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with EinheitenDatentypen; use EinheitenDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with BefehleDatentypen; use BefehleDatentypen;
with EinheitenKonstanten;
with TextnummernKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;
with LeseForschungenDatenbank;

with ForschungstestsLogik;
with AufgabenAllgemeinLogik;
with WegErmittelnLogik;
with MineErmittelnLogik;
with RodenErmittelnLogik;
with FarmErmittelnLogik;
with FestungErmittelnLogik;
with WaldErmittelnLogik;
with EinheitHeilenLogik;
with VerbesserungPluendernLogik;
with EinheitVerbessernLogik;
with EinheitVerschanzenLogik;
with EinheitAufloesenLogik;
with UmwandlungenVerschiedeneDatentypen;
with JaNeinLogik;
with MeldungFestlegenLogik;
with NachGrafiktask;

package body AufgabenLogik is
   
   function AufgabeTesten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        Anfangstest (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                     EinheitartExtern   => LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                     BefehlExtern       => BefehlExtern,
                     VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern))
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
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        Anfangstest (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                     EinheitartExtern   => LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                     BefehlExtern       => BefehlExtern,
                     VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern))
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
     
      -- Kann dieser Fall so noch auftreten? äöü
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        and
          SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.KI_Spieler_Enum
      then
         case
           JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBeschäftigungAbbrechen)
         is
            when True =>
               null;
               
            when False =>
               Put_Line ("Prüfung ob das hier jemals aufgerufen wird oder entfernt werden kann.");
               NachGrafiktask.AktuelleEinheit := EinheitenKonstanten.LeerNummer;
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
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum)
      return Boolean
   is begin
      
      if
        BefehlExtern in BefehleDatentypen.Siedler_Verbesserung_Enum'Range
        and
          EinheitartExtern /= EinheitenDatentypen.Arbeiter_Enum
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl,
                                                        RasseExtern   => RasseExtern);
         return False;
         
      elsif
        BefehlExtern = BefehleDatentypen.Plündern_Enum
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
         when BefehleDatentypen.Siedler_Verbesserung_Enum'Range =>
            if
              False = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => RasseExtern,
                                                                 TechnologieExtern => LeseForschungenDatenbank.Verbesserungen (VerbesserungExtern => BefehlExtern,
                                                                                                                               RasseExtern        => RasseExtern))
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
         when BefehleDatentypen.Siedler_Konstruktionen_Enum'Range =>
            if
              VerbesserungExtern in KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum'Range
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserung,
                                                              RasseExtern   => RasseExtern);
               return False;
               
            elsif
              VerbesserungExtern = UmwandlungenVerschiedeneDatentypen.BefehleNachKartenverbesserung (TasteExtern => BefehlExtern)
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserungExistiert,
                                                              RasseExtern   => RasseExtern);
               return False;
               
            elsif
              (SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
               and
                 VerbesserungExtern /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum)
              and then
                JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLandverbesserungErsetzen) = False
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
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      AufgabenAllgemeinLogik.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        BefehlExtern
      is
         when BefehleDatentypen.Straße_Bauen_Enum =>
            return WegErmittelnLogik.WegErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern,
                                                   KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Mine_Bauen_Enum =>
            return MineErmittelnLogik.MineErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
            
         when BefehleDatentypen.Farm_Bauen_Enum =>
            return FarmErmittelnLogik.FarmErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
            
         when BefehleDatentypen.Festung_Bauen_Enum =>
            return FestungErmittelnLogik.FestungErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           AnlegenTestenExtern      => AnlegenTestenExtern,
                                                           KoordinatenExtern        => KoordinatenExtern);
            
         when BefehleDatentypen.Wald_Aufforsten_Enum =>
            return WaldErmittelnLogik.WaldErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                     KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Roden_Trockenlegen_Enum =>
            return RodenErmittelnLogik.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AnlegenTestenExtern      => AnlegenTestenExtern,
                                                       KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Heilen_Enum =>
            return EinheitHeilenLogik.EinheitHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when BefehleDatentypen.Verschanzen_Enum =>
            return EinheitVerschanzenLogik.Verschanzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when BefehleDatentypen.Auflösen_Enum =>
            return EinheitAufloesenLogik.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         when BefehleDatentypen.Plündern_Enum =>
            return VerbesserungPluendernLogik.VerbesserungPlündern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                     AnlegenTestenExtern      => AnlegenTestenExtern,
                                                                     KoordinatenExtern        => KoordinatenExtern);
         
         when BefehleDatentypen.Einheit_Verbessern_Enum =>
            return EinheitVerbessernLogik.VerbesserungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                               AnlegenTestenExtern      => AnlegenTestenExtern);
      end case;
      
   end AufgabeFestlegen;

end AufgabenLogik;
