pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with StadtBauen;
with Aufgaben;

with KIDatentypen;

with KIAufgabeUmsetzen;
with KIEinheitFestlegenAngreifen;

package body KIAufgabenUmsetzung is

   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AufgabeDurchführen := True;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Stadt_Bauen_Enum =>
            AufgabeDurchführen := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum);
            
         when KIDatentypen.Verbesserung_Anlegen_Enum =>
            AufgabeDurchführen := KIAufgabeUmsetzen.WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören_Enum =>
            null;
            
         when KIDatentypen.Flucht_Enum =>
            null;
            
         when KIDatentypen.Einheit_Heilen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Heilen_Enum);
            
         when KIDatentypen.Einheit_Festsetzen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum);
            
         when KIDatentypen.Einheit_Verbessern_Enum =>
            AufgabeDurchführen := KIAufgabeUmsetzen.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen_Enum =>
            AufgabeDurchführen := KIEinheitFestlegenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigen_Enum =>
            null;
            
         when KIDatentypen.Erkunden_Enum =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts_Enum);
            
         when KIDatentypen.Tut_Nichts_Enum | KIDatentypen.Auf_Transporter_Warten_Enum | KIDatentypen.Einheit_Auflösen_Enum | KIDatentypen.Leer_Aufgabe_Enum =>
            null;
      end case;
      
      --------------------------- Das hier ist so auch noch nicht so sinnvoll, oder?
      case
        AufgabeDurchführen
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts_Enum);
      end case;
      
   end AufgabeUmsetzen;

end KIAufgabenUmsetzung;
