pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitStadtRecords;
with EinheitenKonstanten;
with StadtKonstanten;

with EinheitenDatenbank;

package body LeseEinheitenDatenbank is

   function EinheitenGrafik
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return Wide_Wide_Character
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitenGrafik;
      
   end EinheitenGrafik;
   
   
      
   function EinheitArt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.Einheit_Art_Enum
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitArt;
      
   end EinheitArt;
   
   
   
   function PreisGeld
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;
   
   
   
   function PreisRessourcen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;
   
   
   
   function PermanenteKosten
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      WelcheKostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtePermanenteKosten
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern) < StadtKonstanten.LeerPermanenteKosten
      then
         return EinheitenKonstanten.LeerEinheitListe.PermanenteKosten (WelcheKostenExtern);
      
      else
         return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      end if;
      
   end PermanenteKosten;
   
   
   
   function Anforderungen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;
   
   

   function Passierbarkeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
         
   function MaximaleLebenspunkte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.LebenspunkteVorhanden
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximaleLebenspunkte;
      
   end MaximaleLebenspunkte;
   
   
   
   function MaximaleBewegungspunkte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.VorhandeneBewegungspunkte
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximaleBewegungspunkte < 1.00
      then
         return 1.00;
         
      else
         return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximaleBewegungspunkte;
      end if;
        
      
   end MaximaleBewegungspunkte;
   
   
   
   function WirdVerbessertZu
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.EinheitenIDMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).WirdVerbessertZu;
      
   end WirdVerbessertZu;
   
   
   
   function Beförderungsgrenze
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.MaximaleStädte
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Beförderungsgrenze;
      
   end Beförderungsgrenze;
   
   
   
   function MaximalerRang
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximalerRang;
      
   end MaximalerRang;
   
   
   
   function Reichweite
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Reichweite;
      
   end Reichweite;
   
   
   
   function Angriff
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Angriff < 0
      then
         return 0;
         
      else
         return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Angriff;
      end if;
      
   end Angriff;
   
   
   
   function Verteidigung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Verteidigung < 0
      then
         return 0;
         
      else
         return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Verteidigung;
      end if;
      
   end Verteidigung;
   
   
   
   function KannTransportieren
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).KannTransportieren;
      
   end KannTransportieren;
   
   
   
   function KannTransportiertWerden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).KannTransportiertWerden;
      
   end KannTransportiertWerden;
   
   
   
   function Transportkapazität
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).KannTransportieren > 0
        and
          EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Transportkapazität = 0
      then
         return 1;
         
      elsif
        EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Transportkapazität <= EinheitStadtRecords.TransporterArray'Last
      then
         return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Transportkapazität;
         
      else
         return EinheitStadtRecords.TransporterArray'Last;
      end if;
      
   end Transportkapazität;
   
   
   
   function GanzerEintrag
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return DatenbankRecords.EinheitenListeRecord
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern);
      
   end GanzerEintrag;

end LeseEinheitenDatenbank;
