package JaNeinLogik is
   pragma Elaborate_Body;

   function JaNein
     (FrageZeileExtern : in Positive)
      return Boolean;

private

   AktuelleAuswahl : Natural;

end JaNeinLogik;
