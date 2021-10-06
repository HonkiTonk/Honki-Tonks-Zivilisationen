pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with VerbesserungRoden;
with EinheitenBeschreibungen;
with AufgabenAllgemein;

package body VerbesserungWald is

   function VerbesserungWald
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenDatentypen.Farm
        or
          LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenDatentypen.Mine
      then
         if
           GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch
           and then
             EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8) = True
         then
            null;
            
         elsif
           GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch
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
         when KartenDatentypen.Flachland | KartenDatentypen.Hügel | KartenDatentypen.Karten_Grund_Fluss_Enum'Range | KartenDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => SystemDatentypen.Wald_Aufforsten);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartenDatentypen.Dschungel | KartenDatentypen.Sumpf =>
            if
              VerbesserungRoden.VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   GrundExtern              => GrundExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern) = True
            then
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => SystemDatentypen.Wald_Aufforsten);
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
