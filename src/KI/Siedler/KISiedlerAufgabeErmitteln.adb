pragma SPARK_Mode (On);

with KIDatentypen;
use KIDatentypen;

with EinheitenDatenbank;

with StadtSuchen, KISiedlerAufgabeFestlegen, KIPruefungen, KIAufgabenVerteilt, ZugriffGlobaleVariablen;

package body KISiedlerAufgabeErmitteln is

   procedure SiedlerAufgabeErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GewählteAufgabe := 0;
      
      Wichtigkeit (0) := NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (1) := NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (2) := StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (3) := EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (4) := Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (5) := SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (6) := SichBefestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (7) := SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      WichtigkeitEinsSchleife:
      for WichtigkeitEinsSchleifenwert in WichtigkeitArray'Range loop
         WichtigkeitZweiSchleife:
         for WichtigkeitZweiSchleifenwert in WichtigkeitArray'Range loop
         
            if
              Wichtigkeit (WichtigkeitEinsSchleifenwert) > Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (GewählteAufgabe) < Wichtigkeit (WichtigkeitEinsSchleifenwert)
            then
               GewählteAufgabe := WichtigkeitEinsSchleifenwert;
               
            elsif
              Wichtigkeit (WichtigkeitEinsSchleifenwert) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (GewählteAufgabe) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
            then
               GewählteAufgabe := WichtigkeitZweiSchleifenwert;
               exit WichtigkeitZweiSchleife;
            
            else
               null;
            end if;
         
         end loop WichtigkeitZweiSchleife;
      end loop WichtigkeitEinsSchleife;
      
      KISiedlerAufgabeFestlegen.SiedlerAufgabeFestlegen (GewählteAufgabeExtern    => GewählteAufgabe,
                                                         EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end SiedlerAufgabeErmitteln;
   


   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      VorhandeneStädte := StadtSuchen.AnzahlStädteErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      if
        VorhandeneStädte = 0
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         return 11;
         
      elsif
        GlobaleVariablen.RundenAnzahl > (Positive (VorhandeneStädte) + KIAufgabenVerteilt.AufgabenVerteilt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                             AufgabeExtern            => KIDatentypen.Stadt_Bauen)) * 10
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Stadt_Bauen;
         return 5;
         
      else
         null;
      end if;
      
      return 2;
      
   end NeueStadtBauenGehen;



   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      KartenWert := KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        KartenWert.YAchse
      is
         when 0 =>
            return 0;
            
         when others =>
            return 5;
      end case;  
            
   end StadtUmgebungVerbessern;
                                    
                                    
                                    
   function EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
                                    
   end EinheitAuflösen;
                                    
                                    
                                    
   function Fliehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
                                    
   end Fliehen;
   
   
   
   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      EinheitID := ZugriffGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
        = EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte
      then
         return 0;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
        > EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte / 3 * 2
      then
         return 3;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
        > EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte / 2
      then
         return 5;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte = 1
      then
         return 10;
         
      else
         return 8;
      end if;
      
   end SichHeilen;
   
   
   
   function SichBefestigen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
      
   end SichBefestigen;
   
   
   
   function SichVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
      
   end SichVerbessern;
   
   
   
   function NichtsTun
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 1;
      
   end NichtsTun;

end KISiedlerAufgabeErmitteln;
