pragma SPARK_Mode (On);

with EinheitenDatenbank;

with KINahkampfBodenAufgabeFestlegen, DatenbankVereinfachung;

package body KINahkampfBodenAufgabeErmitteln is

   procedure NahkampfBodenAufgabeErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GewählteAufgabe := 0;
      
      Wichtigkeit (0) := NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (1) := StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (2) := StadtUmgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (3) := EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (4) := Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (5) := SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (6) := SichBefestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (7) := SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (8) := Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (9) := Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
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
      
      return 0;
                                    
   end StadtBewachen;
                                    
                                    
                                    
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
      
      EinheitID := DatenbankVereinfachung.EinheitenIDVereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        = EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte
      then
         return 0;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        > EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte / 3 * 2
      then
         return 3;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte
        > EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, EinheitID).MaximaleLebenspunkte / 2
      then
         return 5;
         
      elsif
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleLebenspunkte = 1
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
   
   
   
   function StadtUmgebungZerstören
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
      
   end StadtUmgebungZerstören;
   
   
   
   function Angreifen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
      
   end Angreifen;
   
   
   
   function Erkunden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 0;
      
   end Erkunden;
   
   
   
   function NichtsTun
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return 1;
      
   end NichtsTun;

end KINahkampfBodenAufgabeErmitteln;
