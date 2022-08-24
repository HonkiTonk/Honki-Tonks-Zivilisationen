pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;
with AufgabenDatentypen;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIEinheitUmsetzenVerbesserungen;
with KIEinheitUmsetzenModernisieren;
with KIEinheitUmsetzenAngreifen;
with KIEinheitUmsetzenErkunden;
with KIEinheitUmsetzenSiedeln;
with KIEinheitUmsetzenBewachen;
with KIEinheitUmsetzenPluendern;
with KIEinheitUmsetzenFliehen;
with KIEinheitUmsetzenHeilen;
with KIEinheitUmsetzenBefestigen;
with KIEinheitUmsetzenVerteidigen;
with KIEinheitUmsetzenTransporter;
with KIEinheitUmsetzenAufloesen;
with KIEinheitUmsetzenAngriffskrieg;
with KIEinheitUmsetzenVerteidigungskrieg;
with KIEinheitUmsetzenNichts;

package body KIEinheitAufgabenumsetzung is

   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Stadt_Bauen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenSiedeln.StadtErrichten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenBewachen.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Anlegen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerbesserungen.WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenPluendern.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Flucht_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenFliehen.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Heilen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenHeilen.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Festsetzen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenBefestigen.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Verbessern_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenModernisieren.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerteidigen.Verteidigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Erkunden_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenErkunden.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Auf_Transporter_Warten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenTransporter.AbholungAbwarten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Auflösen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAufloesen.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when KIDatentypen.Angriffskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAngriffskrieg.AngriffskriegVorbereiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigungskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenVerteidigungskrieg.VerteidigungskriegVorbereiten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Tut_Nichts_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenNichts.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
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

end KIEinheitAufgabenumsetzung;
