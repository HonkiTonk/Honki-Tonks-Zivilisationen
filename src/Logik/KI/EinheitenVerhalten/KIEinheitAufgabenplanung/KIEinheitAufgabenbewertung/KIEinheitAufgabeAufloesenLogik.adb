pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen; use StadtDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;
with LeseWichtiges;
with LeseEinheitenGebaut;

with EinheitenAllgemeinesLogik;

with KIDatentypen; use KIDatentypen;

with KIKriegErmittelnLogik;
with KIGrenzpruefungen;

package body KIEinheitAufgabeAufloesenLogik is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      VorhandeneEinheiten := LeseWichtiges.AnzahlEinheiten (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      if
        VorhandeneEinheiten > SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
      then
         return KIDatentypen.AufgabenWichtigkeitKlein'Last;
      
      elsif
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse) = True
        and
          EinheitenAllgemeinesLogik.Kampfeinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         return StadtzustandKrieg (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         Aufgabenwert := Stadtzustand (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
      if
        -- Das hier ist nicht gleichzusetzen mit der Einheitengrenze!
        MaximaleEinheiten (EinheitRasseNummerExtern.Rasse) + EinheitenDatentypen.MaximaleEinheitenMitNullWert (LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse)) < VorhandeneEinheiten
      then
         Aufgabenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Aufgabenwert,
                                                                ÄnderungExtern      => 3);
         
      else
         null;
      end if;
      
      Aufgabenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Aufgabenwert,
                                                             ÄnderungExtern      => GlobalerZustand (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      return Aufgabenwert;
      
   end EinheitAuflösen;
   
   
   
   -- In einzelne Bereiche aufteilen? äöü
   function Stadtzustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      Zwischenwert := 0;
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Heimatstadt
      is
         when EinheitenKonstanten.LeerHeimatstadt =>
            return Zwischenwert;
            
         when others =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        > 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => Zustandmalus (EinheitRasseNummerExtern.Rasse, KIDatentypen.Hunger_Enum));
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) = 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        > 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => Zustandmalus (EinheitRasseNummerExtern.Rasse, KIDatentypen.Stagniert_Enum));
         
      else
         null;
      end if;
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Ressourcen_Enum)
        > 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => Zustandmalus (EinheitRasseNummerExtern.Rasse, KIDatentypen.Produktionsverlust_Enum));
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) = 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Ressourcen_Enum)
        > 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => Zustandmalus (EinheitRasseNummerExtern.Rasse, KIDatentypen.Produktionsstagnation_Enum));
         
      else
         null;
      end if;
      
      return Zwischenwert;
      
   end Stadtzustand;
   
   
   
   function GlobalerZustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            return 0;
            
         when others =>
            Zwischenwert := 0;
      end case;
         
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        > 0
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => EinheitRasseNummerExtern.Rasse) < 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => Zustandmalus (EinheitRasseNummerExtern.Rasse, KIDatentypen.Geldverlust_Enum));
         
      elsif
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        > 0
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => EinheitRasseNummerExtern.Rasse) = 0
      then
         Zwischenwert := KIGrenzpruefungen.AufgabenWichtigkeit (AktuellerWertExtern => Zwischenwert,
                                                                ÄnderungExtern      => Zustandmalus (EinheitRasseNummerExtern.Rasse, KIDatentypen.Geldstagnation_Enum));
            
      else
         null;
      end if;
      
      return Zwischenwert;
      
   end GlobalerZustand;
   
   
   
   -- Später noch mal erweitern, bringt ja nichts die Einheit zu behalten, wenn die Städte dafür verhungern. äöü
   function StadtzustandKrieg
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      -- Platzhalter
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return -1;
      
   end StadtzustandKrieg;

end KIEinheitAufgabeAufloesenLogik;
