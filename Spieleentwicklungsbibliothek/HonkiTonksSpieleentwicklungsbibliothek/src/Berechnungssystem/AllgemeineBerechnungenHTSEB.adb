package body AllgemeineBerechnungenHTSEB is

   function Basiszeitwert
     (ZusatzwertExtern : in GanzeZahl;
      TeilerExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      return (ZusatzwertExtern + (TeilerExtern - 1)) / TeilerExtern;
      
   end Basiszeitwert;
   
   
   
   function NullprüfungKommazahl
     (KommazahlExtern : in Float)
      return Float
   is begin
      
      if
        KommazahlExtern = KommazahlNullwert
      then
         return KommazahlEinswert;
         
      else
         return KommazahlExtern;
      end if;
      
   end NullprüfungKommazahl;
   
   
   
   function Nullprüfung
     (ZahlExtern : in Integer)
      return Integer
   is begin
      
      if
        ZahlExtern = Nullwert
      then
         return Einswert;
         
      else
         return ZahlExtern;
      end if;
      
   end Nullprüfung;
   
end AllgemeineBerechnungenHTSEB;
