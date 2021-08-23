pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;

with KINahkampfBodenAufgabeFestlegen, EinheitSuchen, KIAufgabenVerteilt, StadtSuchen, KIAufgabenErmittelnAllgemein, LeseStadtGebaut;

package body KINahkampfBodenAufgabeErmitteln is

   procedure NahkampfBodenAufgabeErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GewählteAufgabe := 0;
      
      Wichtigkeit (0) := KIAufgabenErmittelnAllgemein.NichtsTun;
      Wichtigkeit (1) := StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (2) := StadtUmgebungZerstören;
      Wichtigkeit (3) := EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (4) := Fliehen;
      Wichtigkeit (5) := KIAufgabenErmittelnAllgemein.SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (6) := SichBefestigen;
      Wichtigkeit (7) := KIAufgabenErmittelnAllgemein.SichVerbessern;
      Wichtigkeit (8) := Angreifen;
      Wichtigkeit (9) := Erkunden;
      
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
      
      KINahkampfBodenAufgabeFestlegen.NahkampfBodenAufgabeFestlegen (GewählteAufgabeExtern    => GewählteAufgabe,
                                                                     EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end NahkampfBodenAufgabeErmitteln;
   
   
   
   function StadtBewachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      EinheitNummer := 1;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
         end case;
         
         if
           EinheitNummer = GlobaleKonstanten.LeerEinheitStadtNummer
           and
             KIAufgabenVerteilt.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bewachen,
                                                    RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                    ZielKoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)))
               = False
         then
            return 10;
               
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
                                    
   end StadtBewachen;
                                    
                                    
                                    
   function EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      if
        18 + StadtSuchen.AnzahlStädteErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse) > EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                                                                                                                              EinheitTypExtern    => GlobaleDatentypen.Nahkämpfer,
                                                                                                                                              GesuchteMengeExtern => 0)
      then
         return 0;
         
      else
         return 2;
      end if;
      
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
   
   
   
   function StadtUmgebungZerstören
      return Natural
   is begin
      
      return 0;
      
   end StadtUmgebungZerstören;
   
   
   
   function Angreifen
      return Natural
   is begin
      
      return 0;
      
   end Angreifen;
   
   
   
   function Erkunden
      return Natural
   is begin
      
      return 2;
      
   end Erkunden;

end KINahkampfBodenAufgabeErmitteln;
