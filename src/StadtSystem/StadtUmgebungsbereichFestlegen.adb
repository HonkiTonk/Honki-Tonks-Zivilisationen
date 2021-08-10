pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body StadtUmgebungsbereichFestlegen is

   procedure Rassenaufteilung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when GlobaleDatentypen.Menschen =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Kasrodiah =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Lasupin =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Lamustra =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Manuky =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Suroka =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Pryolon =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Talbidahr =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Moru_Phisihl =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Larinos_Lotaris =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Carupex =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Alary =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Tesorahn =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Natries_Zermanis =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Tridatus =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Senelari =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Aspari_2 =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Ekropa =>
            StadtUmgebungMenschen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when GlobaleDatentypen.Leer =>
            -- Dieser Fall sollte niemals eintreten, muss aber mitgenommen werden wegen dem Record.
            null;
      end case;
      
   end Rassenaufteilung;
   
   
   
   procedure StadtUmgebungMenschen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Endwert)) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) >= GlobaleKonstanten.EinwohnerZweitesWachstum
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 3;
         
      elsif
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (TechnologieUmgebungsgröße (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Anfangswert)) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) >= GlobaleKonstanten.EinwohnerErstesWachstum
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 2;         
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 1;
      end if;
      
   end StadtUmgebungMenschen;
   
   
   
   procedure StadtUmgebungKasrodiah
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungKasrodiah;
   
   
   
   procedure StadtUmgebungLasupin
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungLasupin;
   
   
   
   procedure StadtUmgebungLamustra
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungLamustra;
   
   
   
   procedure StadtUmgebungManuky
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungManuky;
   
   
   
   procedure StadtUmgebungSuroka
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungSuroka;
   
   
   
   procedure StadtUmgebungPryolon
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungPryolon;
   
   
   
   procedure StadtUmgebungTalbidahr
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungTalbidahr;
   
   
   
   procedure StadtUmgebungMoruPhisihl
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungMoruPhisihl;
   
   
   
   procedure StadtUmgebungLarinosLotaris
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungLarinosLotaris;
   
   
   
   procedure StadtUmgebungCarupex
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungCarupex;
   
   
   
   procedure StadtUmgebungAlary
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungAlary;
   
   
   
   procedure StadtUmgebungTesorahn
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungTesorahn;
   
   
   
   procedure StadtUmgebungNatriesZermanis
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungNatriesZermanis;
   
   
   
   procedure StadtUmgebungTridatus
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungTridatus;
   
   
   
   procedure StadtUmgebungSenelari
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungSenelari;
   
   
   
   procedure StadtUmgebungAspari2
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungAspari2;
   
   
   
   procedure StadtUmgebungEkropa
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungEkropa;

end StadtUmgebungsbereichFestlegen;
