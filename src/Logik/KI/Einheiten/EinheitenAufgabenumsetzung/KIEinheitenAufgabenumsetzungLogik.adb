with AufgabenDatentypen;
with KartenRecordKonstanten;
with KartenRecords;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIEinheitUmsetzenVerbesserungenLogik;
with KIEinheitUmsetzenModernisierenLogik;
with KIEinheitUmsetzenAngreifenLogik;
with KIEinheitUmsetzenErkundenLogik;
with KIEinheitUmsetzenSiedelnLogik;
with KIEinheitUmsetzenBewachenLogik;
with KIEinheitUmsetzenPluendernLogik;
with KIEinheitUmsetzenFliehenLogik;
with KIEinheitUmsetzenHeilenLogik;
with KIEinheitUmsetzenBefestigenLogik;
with KIEinheitUmsetzenVerteidigenLogik;
with KIEinheitUmsetzenTransporterLogik;
with KIEinheitUmsetzenAufloesenLogik;
with KIEinheitUmsetzenAngriffskriegLogik;
with KIEinheitUmsetzenVerteidigungskriegLogik;
with KIEinheitUmsetzenPlatzMachenLogik;
with KIEinheitHandlungstestsLogik;

-- Die Umsetzung so gestalten wie die Planung? äöü
package body KIEinheitenAufgabenumsetzungLogik is

   function Aufgabenumsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      then
         null;
         
      else
         return False;
      end if;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Stadt_Bauen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenSiedelnLogik.StadtErrichten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Anlegen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerbesserungenLogik.WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenPluendernLogik.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Flucht_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenFliehenLogik.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Heilen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenHeilenLogik.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Festsetzen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenBefestigenLogik.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Verbessern_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenModernisierenLogik.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAngreifenLogik.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerteidigenLogik.Verteidigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Erkunden_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenErkundenLogik.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Auf_Transporter_Warten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenTransporterLogik.AbholungAbwarten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Auflösen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAufloesenLogik.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when KIDatentypen.Angriffskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAngriffskriegLogik.AngriffskriegVorbereiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigungskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerteidigungskriegLogik.VerteidigungskriegVorbereiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Platz_Machen_Enum =>
            -- Wird aktuell nur Aufgerufen um einen vollständig Satz an Funktionen zu haben. äöü
            -- Eventuell später die Aufgabe PlatzMachen doch zuweisen und in der Funktion prüfen ob die Zielkoordinate Leer ist und dann auf Leer setzen lassen? äöü
            AufgabeDurchführen := KIEinheitUmsetzenPlatzMachenLogik.PlatzMachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Planet_Vernichten_Enum =>
            null;
            
         when KIDatentypen.Leer_Aufgabe_Enum =>
            AufgabeDurchführen := False;
      end case;
      
      case
        AufgabeDurchführen
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => AufgabenDatentypen.Leer_Aufgabe_Enum);
      end case;
            
      return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Aufgabenumsetzung;

end KIEinheitenAufgabenumsetzungLogik;
