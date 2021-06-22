pragma SPARK_Mode (On);

with EinheitenDatenbank;

with ZugriffGlobaleVariablen;

package body ZugriffEinheitenDatenbank is
   
   function GrafikOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Wide_Wide_Character
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                ZugriffGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).EinheitenGrafik;
      
   end GrafikOhneID;
   
   
   
   function TypOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenTyp
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                ZugriffGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).EinheitTyp;
      
   end TypOhneID;
   
   

   function GrafikMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Wide_Wide_Character
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitenGrafik;
      
   end GrafikMitID;
   
   
   
   function TypMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.EinheitenTyp
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitTyp;
      
   end TypMitID;

end ZugriffEinheitenDatenbank;
