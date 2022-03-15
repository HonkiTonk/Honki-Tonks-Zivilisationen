pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with TastenbelegungKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with VerbesserungRoden;
with EinheitenBeschreibungen;
with AufgabenAllgemein;

package body VerbesserungWald is

   function VerbesserungWald
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenVerbesserungDatentypen.Farm
        or
          LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenVerbesserungDatentypen.Mine
      then
         if
           GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante
           and then
             EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8) = True
         then
            null;
            
         elsif
           GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante
           and then
             EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8) = False
         then
            return False;
            
         else
            null;
         end if;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when KartenGrundDatentypen.Flachland | KartenGrundDatentypen.Hügel | KartenGrundDatentypen.Karten_Grund_Fluss_Enum'Range | KartenGrundDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => TastenbelegungKonstanten.WaldAufforstenKonstante);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartenGrundDatentypen.Dschungel | KartenGrundDatentypen.Sumpf =>
            if
              VerbesserungRoden.VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   GrundExtern              => GrundExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern) = True
            then
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => TastenbelegungKonstanten.WaldAufforstenKonstante);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => 3,
                                                            RechnenSetzenExtern      => 0);
            
            else
               return False;
            end if;
               
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
      
   end VerbesserungWald;

end VerbesserungWald;
