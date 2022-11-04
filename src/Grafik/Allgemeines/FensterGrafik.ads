pragma Warnings (Off, "*array aggregate*");

package FensterGrafik is
   pragma Elaborate_Body;

   procedure FensterAnpassen;
   procedure BildrateÄndern;
   procedure FensterErzeugen;
   procedure FensterEntfernen;
   procedure FensterLeeren;
   procedure FensterAnzeigen;

private
   
   procedure FensterErzeugenErweitert;
   procedure AktuelleAuflösungFestlegen;
   procedure MauszeigerFestlegen;
   
end FensterGrafik;
