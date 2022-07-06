pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenKonstanten;
with ForschungKonstanten;
with TextKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWichtiges;

with Auswahl;
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
with AufgabeEinheitAussetzen;
with AufgabeEinheitVerschanzen;
with AufgabeEinheitAufloesen;

package body Aufgaben is
   
   function AufgabeTesten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        Anfangstest (RasseExtern      => EinheitRasseNummerExtern.Rasse,
                     EinheitartExtern => LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                            IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                     BefehlExtern     => BefehlExtern)
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
        Anfangstest (RasseExtern      => EinheitRasseNummerExtern.Rasse,
                     EinheitartExtern => LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                            IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)),
                     BefehlExtern     => BefehlExtern)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
     
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        or
          SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
      then
         null;
         
      else
         case
           Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageLandverbesserungErsetzen)
         is
            when True =>
               null;
                     
            when False =>
               return False;
         end case;
      end if;
      
      return AufgabeFestlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               BefehlExtern             => BefehlExtern,
                               AnlegenTestenExtern      => True,
                               KoordinatenExtern        => KoordinatenExtern);
   
   end Aufgabe;
   
   
   
   function Anfangstest
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitartExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
   is begin
      
      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range =>
            if
              ForschungKonstanten.TechnologieVerbesserung (RasseExtern, BefehlExtern) = ForschungKonstanten.ForschungUnmöglich
            then
               return False;

            elsif
              ForschungKonstanten.TechnologieVerbesserung (RasseExtern, BefehlExtern) = ForschungKonstanten.LeerForschung
            then
               null;

            elsif
              LeseWichtiges.Erforscht (RasseExtern             => RasseExtern,
                                       WelcheTechnologieExtern => ForschungKonstanten.TechnologieVerbesserung (RasseExtern, BefehlExtern))
                = True
            then
               null;
         
            else
               return False;
            end if;
            
         when others =>
            null;
      end case;
      
      if
        BefehlExtern in TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range
        and
          EinheitartExtern /= EinheitenDatentypen.Arbeiter_Enum
      then
         return False;
         
      elsif
        BefehlExtern = TastenbelegungDatentypen.Plündern_Enum
        and
          EinheitartExtern = EinheitenDatentypen.Arbeiter_Enum
      then
         return False;
         
      else
         return True;
      end if;
            
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
         
         when TastenbelegungDatentypen.Runde_Aussetzen_Enum =>
            return AufgabeEinheitAussetzen.RundeAussetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
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
