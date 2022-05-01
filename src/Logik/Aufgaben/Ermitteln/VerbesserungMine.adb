pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
-- with LeseKarten;
-- with LeseEinheitenGebaut;

-- with EinheitenBeschreibungen;
with VerbesserungRoden;
with Fehler;

package body VerbesserungMine is

   function VerbesserungMine
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
    --  if
    --    LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = KartenVerbesserungDatentypen.Mine_Enum
     -- then
    --     return False;

    --  elsif
    --    LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
   --   in
    --    KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
    --    and
    --      SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum
   --   then
    --     case
   --        EinheitenBeschreibungen.BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahlExtern => 8)
   --      is
   --         when True =>
    --           null;
                     
   --         when False =>
   --            return False;
   --      end case;

    --  else
    --     null;
    --   end if;
    
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
            
         when KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range =>
            Arbeitswerte := UnterflächeLand (GrundExtern => GrundExtern);
            
         when others =>
            return False;
      end case;
      
      case
        Arbeitswerte.WelcheArbeit
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return False;
            
         when AufgabenDatentypen.Mine_Bauen_Enum =>
            null;
            
         when others =>
            Fehler.LogikFehler (FehlermeldungExtern => "VerbesserungMine.VerbesserungMine - Ungültige Aufgabe wurde ausgewählt.");
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
      
   end VerbesserungMine;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitStadtRecords.ArbeitRecord
   is begin
                     
      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Hügel_Enum =>
            Arbeitszeit := Grundzeit + 2;
            
         when KartengrundDatentypen.Gebirge_Enum =>
            Arbeitszeit := Grundzeit + 4;

         when KartengrundDatentypen.Wald_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
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
            
      return (AufgabenDatentypen.Mine_Bauen_Enum, Arbeitszeit);
   
   end OberflächeLand;
   
   
     
   function UnterflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return EinheitStadtRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Erde_Enum | KartengrundDatentypen.Erdgestein_Enum | KartengrundDatentypen.Sand_Enum =>
            Arbeitszeit := Grundzeit + 2;
            
         when KartengrundDatentypen.Gestein_Enum =>
            Arbeitszeit := Grundzeit + 4;
      end case;
            
      return (AufgabenDatentypen.Mine_Bauen_Enum, Arbeitszeit);
      
   end UnterflächeLand;
     
     
     
   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitStadtRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Küstengrund_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Korallen_Enum | KartengrundDatentypen.Unterwald_Enum =>
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
      end case;
            
      return (AufgabenDatentypen.Mine_Bauen_Enum, Arbeitszeit);
   
   end UnterflächeWasser;

end VerbesserungMine;
