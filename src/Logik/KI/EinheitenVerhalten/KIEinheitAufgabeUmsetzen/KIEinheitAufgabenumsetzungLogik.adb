pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;
with AufgabenDatentypen;

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
with KIEinheitUmsetzenNichtsLogik;

package body KIEinheitAufgabenumsetzungLogik is

   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
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
            
         when KIDatentypen.Tut_Nichts_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
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
      
   end AufgabeUmsetzen;

end KIEinheitAufgabenumsetzungLogik;
