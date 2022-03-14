pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with TastenbelegungKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with EinheitenBeschreibungen;
with AufgabenAllgemein;

package body VerbesserungFestung is

   function VerbesserungFestung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
            
      if
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenDatentypen.Festung
      then
         return False;

      elsif
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
        and
          GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante
      then
         case
           EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
         is
            when True =>
               null;
                     
            when False =>
               return False;
         end case;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when KartenDatentypen.Eis | KartenDatentypen.Flachland | KartenDatentypen.Tundra | KartenDatentypen.Wüste | KartenDatentypen.Hügel | KartenDatentypen.Wald | KartenDatentypen.Dschungel
            | KartenDatentypen.Karten_Grund_Fluss_Enum'Range | KartenDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => TastenbelegungKonstanten.FestungBauenKonstante);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartenDatentypen.Gebirge =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => TastenbelegungKonstanten.FestungBauenKonstante);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 5,
                                                         RechnenSetzenExtern      => 0);
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      return True;
      
   end VerbesserungFestung;

end VerbesserungFestung;
