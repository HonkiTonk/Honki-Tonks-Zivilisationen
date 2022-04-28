pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;

with EinheitenDatenbank;

package body LeseEinheitenDatenbank is

   function EinheitArt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Einheit_Art_Enum
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).EinheitArt;
      
   end EinheitArt;
   
   
   
   function PreisGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;
   
   
   
   function PreisRessourcen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;
   
   
   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      WelcheKostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtePermanenteKosten
   is begin
      
      if
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern) < StadtKonstanten.LeerPermanenteKosten
      then
         return EinheitenKonstanten.LeerEinheitListe.PermanenteKosten (WelcheKostenExtern);
      
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      end if;
      
   end PermanenteKosten;
   
   
   
   function Anforderungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;
   
   

   function Passierbarkeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
         
   function MaximaleLebenspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.LebenspunkteVorhanden
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleLebenspunkte;
      
   end MaximaleLebenspunkte;
   
   
   
   function MaximaleBewegungspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.VorhandeneBewegungspunkte
   is begin
      
      if
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleBewegungspunkte < 1.00
      then
         return 1.00;
         
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleBewegungspunkte;
      end if;
        
      
   end MaximaleBewegungspunkte;
   
   
   
   function WirdVerbessertZu
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.EinheitenIDMitNullWert
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).WirdVerbessertZu;
      
   end WirdVerbessertZu;
   
   
   
   function Beförderungsgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Beförderungsgrenze;
      
   end Beförderungsgrenze;
   
   
   
   function MaximalerRang
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximalerRang;
      
   end MaximalerRang;
   
   
   
   function Reichweite
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Reichweite;
      
   end Reichweite;
   
   
   
   function Angriff
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Angriff;
      
   end Angriff;
   
   
   
   function Verteidigung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Verteidigung;
      
   end Verteidigung;
   
   
   
   function KannTransportieren
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Transport_Enum
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportieren;
      
   end KannTransportieren;
   
   
   
   function KannTransportiertWerden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Transport_Enum
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportiertWerden;
      
   end KannTransportiertWerden;
   
   
   
   function Transportkapazität
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Transportplätze
   is begin
      
      ----------------------- Hier mal noch Konstanten einbauen.
      if
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportieren = EinheitStadtDatentypen.Kein_Transport_Enum
        or
          EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Transportkapazität = 0
      then
         return 0;
         
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Transportkapazität;
      end if;
      
   end Transportkapazität;
   
   
   
   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return DatenbankRecords.EinheitenlisteRecord
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern);
      
   end GanzerEintrag;

end LeseEinheitenDatenbank;