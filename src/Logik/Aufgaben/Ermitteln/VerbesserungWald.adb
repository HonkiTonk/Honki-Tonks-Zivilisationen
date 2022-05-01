pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
-- with LeseKarten;
-- with LeseEinheitenGebaut;

with VerbesserungRoden;
-- with EinheitenBeschreibungen;
with Fehler;

package body VerbesserungWald is

   function VerbesserungWald
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      ------------------------------ JaNein Abfrage endlich mal in einer SFML Version einbauen!
      -- if
      --  LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenVerbesserungDatentypen.Farm_Enum
      --  or
      --    LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenVerbesserungDatentypen.Mine_Enum
      -- then
      --   if
      --     SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum
      --     and then
      --       EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8) = True
      --   then
      --      null;
            
      --    elsif
      --     SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum
      --      and then
      --        EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8) = False
      --    then
      --      return False;
            
      --    else
      --      null;
      --   end if;

      --  else
      --    null;
      --  end if;
    
      VorarbeitNötig := False;
    
      case
        GrundExtern
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range =>
            Arbeitswerte := OberflächeLand (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             GrundExtern              => GrundExtern,
                                             AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum'Range =>
            Arbeitswerte := UnterflächeWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                GrundExtern              => GrundExtern,
                                                AnlegenTestenExtern      => AnlegenTestenExtern);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.WelcheArbeit
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Wald_Aufforsten_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "VerbesserungWald.VerbesserungWald - Ungültige Aufgabe wurde ausgewählt.");
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            if
              VorarbeitNötig
            then
               SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BeschäftigungExtern     => Arbeitswerte.WelcheArbeit);
               SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                                      RechnenSetzenExtern      => 0);
               
            else
               SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern     => Arbeitswerte.WelcheArbeit);
               SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                            ZeitExtern               => Arbeitswerte.Arbeitszeit,
                                                            RechnenSetzenExtern      => 0);
            end if;
            
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungWald;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitStadtRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Hügel_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
            if
              VerbesserungRoden.VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   GrundExtern              => GrundExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern)
              = True
            then
               Arbeitszeit := Grundzeit + 2;
               VorarbeitNötig := True;
            
            else
               return EinheitenKonstanten.KeineArbeit;
            end if;
               
         when others =>
            return EinheitenKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Wald_Aufforsten_Enum, Arbeitszeit);
   
   end OberflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitStadtRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Meeresgrund_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Korallen_Enum =>
            if
              VerbesserungRoden.VerbesserungRoden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   GrundExtern              => GrundExtern,
                                                   AnlegenTestenExtern      => AnlegenTestenExtern)
              = True
            then
               Arbeitszeit := Grundzeit + 2;
               VorarbeitNötig := True;
               
            else
               return EinheitenKonstanten.KeineArbeit;
            end if;
               
         when others =>
            return EinheitenKonstanten.KeineArbeit;
      end case;
            
      return (AufgabenDatentypen.Wald_Aufforsten_Enum, Arbeitszeit);
   
   end UnterflächeWasser;

end VerbesserungWald;
