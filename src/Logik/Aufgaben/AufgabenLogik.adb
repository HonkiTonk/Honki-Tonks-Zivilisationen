with TextnummernKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;
with LeseForschungenDatenbank;

with ForschungstestsLogik;
with AufgabeFestlegenLogik;
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
with FeldeffektErmittelnLogik;

package body AufgabenLogik is
   
   function Aufgabe
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        Anfangstest (SpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                     EinheitartExtern   => LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)),
                     BefehlExtern       => BefehlExtern,
                     VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern))
      is
         when True =>
            return AufgabeFestlegen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                     BefehlExtern               => BefehlExtern,
                                     AnlegenTestenExtern        => AnlegenTestenExtern,
                                     KoordinatenExtern          => KoordinatenExtern);
            
         when False =>
            return False;
      end case;
      
   end Aufgabe;
   
   
   
   function Anfangstest
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EinheitartExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum)
      return Boolean
   is
      use type EinheitenDatentypen.Einheitart_Enum;
      use type BefehleDatentypen.Einheitenbelegung_Enum;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      if
        EinheitartExtern /= EinheitenDatentypen.Arbeiter_Enum
        and
          (BefehlExtern in BefehleDatentypen.Siedler_Verbesserung_Enum'Range
           or
             BefehlExtern = BefehleDatentypen.Feldeffekte_Entfernen_Enum)
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl,
                                                        SpeziesExtern => SpeziesExtern);
         return False;
         
      elsif
        BefehlExtern = BefehleDatentypen.Plündern_Enum
        and
          EinheitartExtern = EinheitenDatentypen.Arbeiter_Enum
      then
         MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl,
                                                        SpeziesExtern => SpeziesExtern);
         return False;
         
      else
         null;
      end if;
      
      case
        BefehlExtern
      is
         when BefehleDatentypen.Siedler_Verbesserung_Enum'Range =>
            VerbesserungErforscht := ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => SpeziesExtern,
                                                                                TechnologieExtern => LeseForschungenDatenbank.Verbesserungen (VerbesserungExtern => BefehlExtern,
                                                                                                                                              SpeziesExtern      => SpeziesExtern));
            
            if
              VerbesserungErforscht = False
              and
                LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserungTechnologie,
                                                              SpeziesExtern => SpeziesExtern);
               return False;
               
            elsif
              VerbesserungErforscht = False
            then
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
              VerbesserungExtern in KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserung,
                                                              SpeziesExtern => SpeziesExtern);
               return False;
               
            elsif
              VerbesserungExtern = UmwandlungenVerschiedeneDatentypen.BefehleNachKartenverbesserung (TasteExtern => BefehlExtern)
            then
               MeldungFestlegenLogik.SpielermeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungVerbesserungExistiert,
                                                              SpeziesExtern => SpeziesExtern);
               return False;
               
            elsif
              (LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheiten_Aufgaben_Baulos_Enum;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
            
      AufgabeFestlegenLogik.Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        BefehlExtern
      is
         when BefehleDatentypen.Straße_Bauen_Enum =>
            return WegErmittelnLogik.WegErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   AnlegenTestenExtern        => AnlegenTestenExtern,
                                                   KoordinatenExtern          => KoordinatenExtern);
         
         when BefehleDatentypen.Mine_Bauen_Enum =>
            return MineErmittelnLogik.MineErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern        => AnlegenTestenExtern,
                                                     KoordinatenExtern          => KoordinatenExtern);
            
         when BefehleDatentypen.Farm_Bauen_Enum =>
            return FarmErmittelnLogik.FarmErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern        => AnlegenTestenExtern,
                                                     KoordinatenExtern          => KoordinatenExtern);
            
         when BefehleDatentypen.Festung_Bauen_Enum =>
            return FestungErmittelnLogik.FestungErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           AnlegenTestenExtern        => AnlegenTestenExtern,
                                                           KoordinatenExtern          => KoordinatenExtern);
            
         when BefehleDatentypen.Wald_Aufforsten_Enum =>
            return WaldErmittelnLogik.WaldErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern        => AnlegenTestenExtern,
                                                     KoordinatenExtern          => KoordinatenExtern);
         
         when BefehleDatentypen.Roden_Trockenlegen_Enum =>
            return RodenErmittelnLogik.RodenErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       AnlegenTestenExtern        => AnlegenTestenExtern,
                                                       KoordinatenExtern          => KoordinatenExtern);
            
         when BefehleDatentypen.Feldeffekte_Entfernen_Enum =>
            return FeldeffektErmittelnLogik.FeldeffektErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                 AnlegenTestenExtern        => AnlegenTestenExtern,
                                                                 KoordinatenExtern          => KoordinatenExtern);
            
         when BefehleDatentypen.Heilen_Enum =>
            return EinheitHeilenLogik.EinheitHeilen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     AnlegenTestenExtern        => AnlegenTestenExtern);
            
         when BefehleDatentypen.Verschanzen_Enum =>
            return EinheitVerschanzenLogik.Verschanzen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
         when BefehleDatentypen.Auflösen_Enum =>
            return EinheitAufloesenLogik.EinheitAuflösen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
         when BefehleDatentypen.Plündern_Enum =>
            return VerbesserungPluendernLogik.VerbesserungPlündern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                     AnlegenTestenExtern        => AnlegenTestenExtern,
                                                                     KoordinatenExtern          => KoordinatenExtern);
         
         when BefehleDatentypen.Einheit_Verbessern_Enum =>
            return EinheitVerbessernLogik.VerbesserungEinheit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                               AnlegenTestenExtern        => AnlegenTestenExtern);
      end case;
      
   end AufgabeFestlegen;

end AufgabenLogik;
