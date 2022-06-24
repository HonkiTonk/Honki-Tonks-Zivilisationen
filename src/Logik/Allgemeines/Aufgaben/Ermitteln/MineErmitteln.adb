pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with RueckgabeDatentypen;
with EinheitenKonstanten;
with TextKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten;
with LeseEinheitenGebaut;

with RodenErmitteln;
with Fehler;
with Auswahl;

package body MineErmitteln is

   function MineErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      VorhandeneVerbesserung := LeseKarten.Verbesserung (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      if
        VorhandeneVerbesserung = KartenVerbesserungDatentypen.Mine_Enum
      then
         return False;

      elsif
        VorhandeneVerbesserung in KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range
        and
          SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
      then
         case
           Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageLandverbesserungErsetzen)
         is
            when RueckgabeDatentypen.Ja_Enum =>
               null;
                     
            when RueckgabeDatentypen.Nein_Enum =>
               return False;
         end case;

      else
         null;
      end if;
    
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
            Fehler.LogikFehler (FehlermeldungExtern => "MineErmitteln.MineErmitteln - Ungültige Aufgabe wurde ausgewählt.");
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
      
   end MineErmitteln;
   
   
   
   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitenRecords.ArbeitRecord
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
              RodenErmitteln.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
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
      return EinheitenRecords.ArbeitRecord
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum;
      AnlegenTestenExtern : in Boolean)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Küstengrund_Enum =>
            Arbeitszeit := Grundzeit + 2;

         when KartengrundDatentypen.Korallen_Enum | KartengrundDatentypen.Unterwald_Enum =>
            if
              RodenErmitteln.RodenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
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

end MineErmitteln;
