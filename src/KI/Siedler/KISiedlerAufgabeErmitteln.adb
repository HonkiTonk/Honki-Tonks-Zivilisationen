pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;
use KIDatentypen;

with StadtSuchen, KISiedlerAufgabeFestlegen, KIPruefungen, KIAufgabenVerteilt, KIAufgabenErmittelnAllgemein, RassenAllgemein;

package body KISiedlerAufgabeErmitteln is

   procedure SiedlerAufgabeErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GewählteAufgabe := 0;
      
      Wichtigkeit (0) := KIAufgabenErmittelnAllgemein.NichtsTun;
      Wichtigkeit (1) := NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (2) := StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (3) := EinheitAuflösen;
      Wichtigkeit (4) := Fliehen;
      Wichtigkeit (5) := KIAufgabenErmittelnAllgemein.SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (6) := SichBefestigen;
      Wichtigkeit (7) := KIAufgabenErmittelnAllgemein.SichVerbessern;
      
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
        VorhandeneStädte = GlobaleKonstanten.LeerEinheitStadtNummer
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
      
      if
        RassenAllgemein.RassenExpansion (EinheitRasseNummerExtern.Rasse) > 10
      then
         return 3;
         
      else
         return 2;
      end if;
      
   end NeueStadtBauenGehen;



   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      case
        KIPruefungen.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
            return 0;
            
         when others =>
            return 5;
      end case;  
            
   end StadtUmgebungVerbessern;
                                    
                                    
                                    
   function EinheitAuflösen
     return Natural
   is begin
      
      return 0;
                                    
   end EinheitAuflösen;
                                    
                                    
                                    
   function Fliehen
     return Natural
   is begin
      
      return 0;
                                    
   end Fliehen;
   
   
   
   function SichBefestigen
     return Natural
   is begin
      
      return 0;
      
   end SichBefestigen;

end KISiedlerAufgabeErmitteln;
