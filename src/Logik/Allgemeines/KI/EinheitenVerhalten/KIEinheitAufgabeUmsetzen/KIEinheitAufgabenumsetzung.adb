pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with StadtBauen;
with Aufgaben;

with KIDatentypen;

with KIEinheitUmsetzenVerbesserungen;
with KIEinheitUmsetzenModernisieren;
with KIEinheitUmsetzenAngreifen;

package body KIEinheitAufgabenumsetzung is

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
            AufgabeDurchführen := KIEinheitUmsetzenVerbesserungen.WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören_Enum =>
            AufgabeDurchführen := False;
            
         when KIDatentypen.Flucht_Enum =>
            AufgabeDurchführen := False;
            
         when KIDatentypen.Einheit_Heilen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Heilen_Enum);
            
         when KIDatentypen.Einheit_Festsetzen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum);
            
         when KIDatentypen.Einheit_Verbessern_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenModernisieren.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen_Enum =>
            AufgabeDurchführen := KIEinheitUmsetzenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            -- KIEinheitFestlegenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigen_Enum =>
            AufgabeDurchführen := False;
            
         when KIDatentypen.Erkunden_Enum =>
            AufgabeDurchführen := False;
            
         when KIDatentypen.Auf_Transporter_Warten_Enum =>
            AufgabeDurchführen := False;
            
         when KIDatentypen.Einheit_Auflösen_Enum =>
            AufgabeDurchführen := False;
               
         when KIDatentypen.Angriffskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := False;
            
         when KIDatentypen.Verteidigungskrieg_Vorbereiten_Enum =>
            AufgabeDurchführen := False;
            
         when KIDatentypen.Tut_Nichts_Enum =>
            -- Sollte theoretisch schon vorher aus der Schleife springen, aber sicherheitshalber mal so definiert drinnen lassen.
            AufgabeDurchführen := True;
            
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
                                                    BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
      end case;
      
   end AufgabeUmsetzen;

end KIEinheitAufgabenumsetzung;
