with AufgabenDatentypen;
with KartenRecordKonstanten;
with KartenRecords;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      AktuelleBeschäftigung := LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        AktuelleBeschäftigung /= KIDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      then
         null;
         
      else
         return False;
      end if;
      
      case
        AktuelleBeschäftigung
      is
         when KIDatentypen.Stadt_Bauen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenSiedelnLogik.StadtErrichten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenBewachenLogik.StadtBewachen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Verbesserung_Anlegen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerbesserungenLogik.WelcheVerbesserungAnlegen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenPluendernLogik.StadtumgebungZerstören (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Flucht_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenFliehenLogik.Fliehen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Einheit_Heilen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenHeilenLogik.Heilen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Einheit_Festsetzen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenBefestigenLogik.Befestigen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Einheit_Verbessern_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenModernisierenLogik.EinheitVerbessern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Angreifen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAngreifenLogik.Angreifen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Verteidigen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerteidigenLogik.Verteidigen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Erkunden_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenErkundenLogik.Erkunden (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Auf_Transporter_Warten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenTransporterLogik.AbholungAbwarten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Einheit_Auflösen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAufloesenLogik.EinheitAuflösen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
         when KIDatentypen.Angriffskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAngriffskriegLogik.AngriffskriegVorbereiten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Verteidigungskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerteidigungskriegLogik.VerteidigungskriegVorbereiten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIDatentypen.Platz_Machen_Enum =>
            -- Wird aktuell nur Aufgerufen um einen vollständig Satz an Funktionen zu haben. äöü
            -- Eventuell später die Aufgabe PlatzMachen doch zuweisen und in der Funktion prüfen ob die Zielkoordinate Leer ist und dann auf Leer setzen lassen? äöü
            AufgabeDurchführen := KIEinheitUmsetzenPlatzMachenLogik.PlatzMachen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
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
            SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Leer_Aufgabe_Enum);
            SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => AufgabenDatentypen.Leer_Aufgabe_Enum);
      end case;
            
      return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Aufgabenumsetzung;

end KIEinheitenAufgabenumsetzungLogik;
