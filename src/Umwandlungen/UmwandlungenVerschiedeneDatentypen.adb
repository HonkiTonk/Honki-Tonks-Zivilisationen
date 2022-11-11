package body UmwandlungenVerschiedeneDatentypen is

   function BefehleNachKartenverbesserung
     (TasteExtern : in BefehleDatentypen.Siedler_Konstruktionen_Enum)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum
   is begin
      
      return BefehleKartenverbesserung (TasteExtern);
      
   end BefehleNachKartenverbesserung;
   
   
   
   function KartenverbesserungNachBefehle
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum)
      return BefehleDatentypen.Siedler_Konstruktionen_Enum
   is begin
      
      return KartenverbesserungBefehle (VerbesserungExtern);
      
   end KartenverbesserungNachBefehle;
   
   
   
   function RückgabeNachRasse
     (RückgabeExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Verwendet_Enum
   is begin
      
      return RückgabeRasse (RückgabeExtern);
      
   end RückgabeNachRasse;
   
   
   
   function KartentemperaturrückgabeNachKartentemperatur
     (RückgabeExtern : in RueckgabeDatentypen.Kartentemperatur_Enum)
      return KartenartDatentypen.Kartentemperatur_Enum
   is begin
      
      return KartentemperaturrückgabeKartentemperatur (RückgabeExtern);
      
   end KartentemperaturrückgabeNachKartentemperatur;
   
   
   
   function KartenressourcenrückgabeNachKartenressource
     (RückgabeExtern : in RueckgabeDatentypen.Kartenressourcen_Enum)
      return KartenartDatentypen.Kartenressourcen_Enum
   is begin
      
      return KartenressourcenrückgabeKartenressource (RückgabeExtern);
      
   end KartenressourcenrückgabeNachKartenressource;
   
   
   
   function RückgabeNachSchwierigkeitsgrad
     (RückgabeExtern : in RueckgabeDatentypen.Schwierigkeitsgrad_Enum)
      return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      return RückgabeSchwierigkeitsgrad (RückgabeExtern);
      
   end RückgabeNachSchwierigkeitsgrad;

end UmwandlungenVerschiedeneDatentypen;
