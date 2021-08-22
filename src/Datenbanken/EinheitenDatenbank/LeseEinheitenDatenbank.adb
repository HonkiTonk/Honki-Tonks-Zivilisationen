pragma SPARK_Mode (On);

with EinheitenDatenbank;

package body LeseEinheitenDatenbank is

   function EinheitenGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return Wide_Wide_Character
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitenGrafik;
      
   end EinheitenGrafik;
   
   
      
   function EinheitArt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.Einheit_Art_Enum
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitArt;
      
   end EinheitArt;
   
   
   
   function PreisGeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;
   
   
   
   function PreisRessourcen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;
   
   
   
   function PermanenteKosten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      WelcheKostenExtern : in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum)
      return GlobaleDatentypen.GesamtePermanenteKosten
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      
   end PermanenteKosten;
   
   
   
   function Anforderungen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;
   
      

   function Passierbarkeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID;
      WelcheUmgebungExtern : in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
         
   function MaximaleLebenspunkte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.MaximaleEinheiten
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximaleLebenspunkte;
      
   end MaximaleLebenspunkte;
   
   
   
   function MaximaleBewegungspunkte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.BewegungFloat
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximaleBewegungspunkte;
      
   end MaximaleBewegungspunkte;
   
   
   
   function WirdVerbessertZu
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.EinheitenIDMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).WirdVerbessertZu;
      
   end WirdVerbessertZu;
   
   
   
   function Beförderungsgrenze
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.MaximaleStädte
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Beförderungsgrenze;
      
   end Beförderungsgrenze;
   
   
   
   function MaximalerRang
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximalerRang;
      
   end MaximalerRang;
   
   
   
   function Reichweite
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Reichweite;
      
   end Reichweite;
   
   
   
   function Angriff
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Angriff;
      
   end Angriff;
   
   
   
   function Verteidigung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Verteidigung;
      
   end Verteidigung;
   
   
   
   function KannTransportieren
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).KannTransportieren;
      
   end KannTransportieren;
   
   
   
   function KannTransportiertWerden
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).KannTransportiertWerden;
      
   end KannTransportiertWerden;
   
   
   
   function Transportkapazität
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Transportkapazität;
      
   end Transportkapazität;

end LeseEinheitenDatenbank;
